Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723AD1EB137
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFAVoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:44:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33196 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFAVoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:44:22 -0400
Received: by mail-io1-f68.google.com with SMTP id k18so8658006ion.0;
        Mon, 01 Jun 2020 14:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0fQXkfKxGsovbxT2SSp2NgdLtTyfkAwO1EpJKvPUFM=;
        b=VBo/fLkX5vLfxt09QI91y0/6M2bxue3v3uXZHnZBWt8h8z63OiGMujR6yhQMp3H94Z
         FszzfwKcPKKTBF9VQMwn2i1y3bm7y/cQSky5a6IzxfMYy5ndGm7JGlZiTTAujUFc08Fg
         8+5+qiFo51yUfxZavY0MrYFIjzr1Z8nf5OaHxQQq0rnOB+0M52jzkS7Zlpc94wVSoTFn
         YoZ1sBZUFK9xagyUsHZqX4FbDGTJScmtZi3rHOfbol2Z6bJjRDJ/IVziXw4zXMOb0/eX
         fmF81Nt9Ecxx7zhbMcxm8ufm6PUv954X4O5biUS6itrsPyFa7FV4eWdyel4J9upPwjhL
         X0dA==
X-Gm-Message-State: AOAM533RSOrzM1tG37cYHZ6HcXH/tiwQIhxqhLtF4st0nfOvqJdT//iO
        K6eD4uMmrd2oC+1uGmEa/+9tl9g=
X-Google-Smtp-Source: ABdhPJweQipFvnHxP9vIa7uxNXcFa4vSSM18AjlY3A9aGY9jyFlcgQeQccfs72rDlXOBgG9zZNy/OQ==
X-Received: by 2002:a6b:7841:: with SMTP id h1mr20945025iop.101.1591047862212;
        Mon, 01 Jun 2020 14:44:22 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p69sm411946ili.75.2020.06.01.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:44:21 -0700 (PDT)
Received: (nullmailer pid 1556703 invoked by uid 1000);
        Mon, 01 Jun 2020 21:44:20 -0000
Date:   Mon, 1 Jun 2020 15:44:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 01/14] PCI: brcmstb: PCIE_BRCMSTB depends on
 ARCH_BRCMSTB
Message-ID: <20200601214420.GA1556624@bogus>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526191303.1492-2-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 May 2020 15:12:40 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Have PCIE_BRCMSTB depend on ARCH_BRCMSTB.  Also set the default value to
> ARCH_BRCMSTB.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
