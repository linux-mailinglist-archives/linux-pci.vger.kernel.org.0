Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE119E73
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2019 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEJNsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 May 2019 09:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfEJNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 May 2019 09:48:14 -0400
Received: from localhost (50-81-62-123.client.mchsi.com [50.81.62.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21982216C4;
        Fri, 10 May 2019 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557496093;
        bh=VPn/gLc6ll7XzDN6XuKc5GqfSmAzTCKwzEJ4nUSHANs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ds2ulXsUQaunkBy99np60paEr1NPngT+ZaNy0vGNwSXhiWvUdGvOa6o5Xf8S46o3d
         6OibxoZzn+b5SSBuL3gIN+2/RYxTPDPN4Qbzsx/gGsmnTTEY3vYv2xUetPyyTywz4U
         xs8C16yx5OrMi7r/zto6bwYsLf4oYOcvmv6zSw4M=
Date:   Fri, 10 May 2019 08:48:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hou Zhiqiang <zhiqiang.hou@nxp.com>,
        Karthikeyan M <m.karthikeyan@mobiveil.co.in>
Cc:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Message-ID: <20190510134811.GG235064@google.com>
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 07:45:16AM -0400, Subrahmanya Lingappa wrote:
> Add Karthikeyan M and Z.Q. Hou as new maintainers of Mobiveil controller
> driver.
> 
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

I'd like to include this ASAP so patches get sent to the right place,
and I want to make sure we spell the names and email addresses
correctly.

Zhiqiang, you consistently use "Hou Zhiqiang <Zhiqiang.Hou@nxp.com>"
for sign-offs [1] (except for "Z.q. Hou" in email headers).  Can you
ack that the updated patch below is correct for you?

Karthikeyan, I don't see any email or commits from you yet, so I'd really
like your ack along with the canonical name/email address you prefer.
There is another Karthikeyan already in MAINTAINERS, so hopefully we can
avoid any confusion.

[1] git log --format="%an <%ae>" --author=[Zz]hiqiang

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a52061..08295a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11900,7 +11900,8 @@ F:	include/linux/switchtec.h
>  F:	drivers/ntb/hw/mscc/
>  
>  PCI DRIVER FOR MOBIVEIL PCIE IP
> -M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> +M:	Karthikeyan M <m.karthikeyan@mobiveil.co.in>
> +M:	Z.q. Hou <zhiqiang.hou@nxp.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt


commit d260ff8d3353
Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue May 7 07:45:16 2019 -0400

    MAINTAINERS: Add Karthikeyan M and Hou Zhiqiang for Mobiveil PCI
    
    Add Karthikeyan M and Hou Zhiqiang as new maintainers of Mobiveil
    controller driver.
    
    Link: https://lore.kernel.org/linux-pci/1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in
    Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
    [bhelgaas: update names/email addresses to match usage in git history]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..42d7f44cc0e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11880,7 +11880,8 @@ F:	include/linux/switchtec.h
 F:	drivers/ntb/hw/mscc/
 
 PCI DRIVER FOR MOBIVEIL PCIE IP
-M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+M:	Karthikeyan M <m.karthikeyan@mobiveil.co.in>
+M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
