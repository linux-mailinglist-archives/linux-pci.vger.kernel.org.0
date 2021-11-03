Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BC44439B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhKCOdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 10:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhKCOdi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 10:33:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31E4A61050;
        Wed,  3 Nov 2021 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635949861;
        bh=N5Mg6vArlWNEiIMvZeF4xSwCRRgbnJ1JR10vTfGkNm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NWZC7exJ3FFlKoQiJ0mpdkryWf6aR/jLrNXkgToN7yyhMmPWDVTYIyH+3zQwxNrUI
         XxkFWIs1hvS6ciYKWeVYq570sHZFZT0uOwkZWO2fhlxb5oizs8BykhvQ6IKHJ9Le/t
         LHc7o/OLryb1S9LRR2Sa/8d53J5elP1M0hzjbFYDz1oFnvJmKFEPXk3FEMyw3vpnsF
         NdN1nwgxk4FhiOS0wuOYEje8t5GTUWkS4bNuqSJSthXftYNJuXFbhZKsKJCRwfCgfM
         YjuhygGyk3We7uyzYHeRZsRWwNF5soLNqeLLVkg2qcpn7cNZFoZdEUgPiQAFIyl4OQ
         ucYeeQPB2pSPw==
Date:   Wed, 3 Nov 2021 09:30:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] PCI: kirin: Fix of_node_put() issue in pcie-kirin
Message-ID: <20211103143059.GA683503@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103062518.25695-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Mauro, author of code being changed,
Rob for "of_pci_get_devfn()" naming question]

On Wed, Nov 03, 2021 at 02:25:18AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before return.
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter. Replace return by goto here.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 06017e826832..23a2c076ce53 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -422,7 +422,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto put_node;
>  			}
>  
>  			ret = of_pci_get_devfn(child);

This is a change to the code added here:
  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=31bd24f0cfe0

This fix looks right to me; all the other early exits from the inner
loop drop the "child" reference.

But this is a nested loop and the *outer* loop also increments
refcounts, and I don't see that outer loop reference on "parent" being
dropped at all:

    for_each_available_child_of_node(node, parent) { 
      for_each_available_child_of_node(parent, child) {
	...
	if (error)
	  goto put_node;
      }
    }

  put_node:
    of_node_put(child);

The "of_pci_get_devfn()" immediately after is unrelated, but possibly
a confusing name.  "Get" often suggests a reference count being
increased, but that's not the case with of_pci_get_devfn().

I want to fix this before sending a pull request to Linus, and I can
easily squash it into a local branch, but I need an ack from Mauro
that this patch is correct and also a fix or explanation for the outer
loop reference situation.

Bjorn
