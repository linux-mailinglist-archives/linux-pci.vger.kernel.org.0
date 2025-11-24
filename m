Return-Path: <linux-pci+bounces-41978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E0C82025
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B6403494AF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC492BEC41;
	Mon, 24 Nov 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzudF/in"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DD28643C;
	Mon, 24 Nov 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007377; cv=none; b=n22lY/azIgGH8CAAbNox9AajyVhnxFyXxLNEaF0T80f4uoxp6Ce/h5egBzLrbXUVyTwTsuoZt0p/lK7/GQa2P1hoCV+IR+tjT5ImFkuSszSpK+Gc1Xv+GScPdb6FaCdUQlCNfiZAz3oVLbSxOr+rGqiOAYGNdzwa4Y8Zt9qGoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007377; c=relaxed/simple;
	bh=vVJOkgGpk1orF0T+8LRcES0SRASEEkMsr2eN64SHTYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lw4AOFw9OkMtmaVEWOETWm5ag30og+ddhtUVtdRuI4J1++emxXEHfyLSC8TSvi+Uw7BeSsD+tzNKXU6koNRDGNFAfOHWFmQBAPW3pFwArawZNAZVjLGi4UCxFGTQFJY4/+jSK6lclZZGpstNurMHiHRzXDba60PLHRRzx6uSnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzudF/in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B9BC4CEF1;
	Mon, 24 Nov 2025 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764007377;
	bh=vVJOkgGpk1orF0T+8LRcES0SRASEEkMsr2eN64SHTYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZzudF/inSo3Nt0LWRO4DqPkXgBSR4SQxZPAUx9U763h8oDk4K4NhEnYOA0LidBymt
	 agY27Xz2u8S8WeuSPVgCqk2mUeX17RsAyd0j5BXl5z2QYr4kYRozXz2W7qvRYjazqv
	 UHFJH0g0t8NUF7SlAENzs4/aft3FHR8vNJwyihtmymY2MI2dQdGQ0LwPtMLEi0bGim
	 7/Xz5U2oBRAKi/g9VHxkDo/8JvsNkZ4d6uB2DWLIMzKnnMFVYllTXXfatkpv8wXhr3
	 vIzB2EyXffHD5OQuxQH4nt3IUEkZ+R1Jz9243RcbRAr6c8OuTMlGQ2/IeOjyKu49xy
	 uaJuvBTeBf2Hw==
Date: Mon, 24 Nov 2025 12:02:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <Hans.Zhang@cixtech.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Manikandan Karunakaran Pillai <mpillai@cadence.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH -next] PCI: cadence:
 remove unneeded semicolon
Message-ID: <20251124180255.GA2700418@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB472685FE5109782EF14C62DB9DD4A@KL1PR0601MB4726.apcprd06.prod.outlook.com>

On Thu, Nov 20, 2025 at 09:41:43AM +0000, Hans Zhang wrote:
> + Manikandan
> 
> -----邮件原件-----
> 发件人: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> 
> 发送时间: 2025年11月20日 17:35
> 收件人: lpieralisi@kernel.org
> 抄送: kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jiapeng Chong <jiapeng.chong@linux.alibaba.com>; Abaci Robot <abaci@linux.alibaba.com>
> 主题: [PATCH -next] PCI: cadence: remove unneeded semicolon
> 
> [You don't often get email from jiapeng.chong@linux.alibaba.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> No functional modification involved.
> 
> ./drivers/pci/controller/cadence/pcie-cadence.h:217:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=27326
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Squashed this into the commit (f5fa6c33b173 ("PCI: cadence: Add
support for High Perf Architecture (HPA) controller"), no need to
repost this.

There's a rash of this error.  Do you know of any others in
drivers/pci/?

> ---
>  drivers/pci/controller/cadence/pcie-cadence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 717921411ed9..311a13ae46e7 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -214,7 +214,7 @@ static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_re
>                 break;
>         default:
>                 break;
> -       };
> +       }
>         return offset;
>  }
> 
> --
> 2.43.5
> 
> 

