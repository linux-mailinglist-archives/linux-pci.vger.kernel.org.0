Return-Path: <linux-pci+bounces-19366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B51A03468
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 02:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592341885311
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780245009;
	Tue,  7 Jan 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fG1w367H"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FB11CAF;
	Tue,  7 Jan 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212497; cv=none; b=JvpgsTjLnsBFj4oGCdxjwjllk5HTrVZkKDBRljH1aUfoBEaVzDwUqUS5N7ejbgeZeeHBl0wiMrfukJ6ACzFs4N63NKI9dLp1767sOG2lhSatVZidUNdfA/tjLIwMEJihjOVaB4qfKj5fDdo2EMG3GgJg97nhY6I8bFcQbKpCgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212497; c=relaxed/simple;
	bh=bxAbinhnqsqR0bB/1m/C/0inhhyDPuGbIWs8i2TynRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dR/o3UhF3x2x2PA2g4CBx8DsdluWqunCj3zmOF+QSvBowjFnsZ96bgJIVAXxz1pduacTnOfEttRQCjV9zYGDm6L2I9zr4SkDUNij/VehiK6d9CaLLKB37bUvjXmla+/wXORiLJzASbqZyfhJvKh+yj+x5o2jRwSiZ0f/qy7kO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fG1w367H; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736212486; bh=SKgKQ+GWuP3jxY5UVCwcYaK/abcNlm0ZnxRxLnZzHp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fG1w367H/qzkcXD0ACkspSXWZHMVGVpcdaGL1ff8CfJFGe5W2U5xXeWbAulrVvHfO
	 GX1WpdjsbbCv2X7NyqEmOgNNMYjmy6rp1go9r0m2rL3tNzpnbt9qsIWWK762xHyy/x
	 2OBGKLhdllIzfAXRpwyWH+GAw7SgcEQJ7NM7OpPA=
Received: from Ubuntu.. ([240e:305:25d4:e300:9386:9eae:9d33:24a8])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id EC6936F8; Tue, 07 Jan 2025 08:59:06 +0800
X-QQ-mid: xmsmtpt1736211546twe76ycc9
Message-ID: <tencent_92781245E66AD47A12F3B907548289877308@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqK7RQBWx/lkwCl2Y5hN0Ipq7g0N5DF5z8Usv/HNxxMbyktWEfcH
	 KxKKzjqEf57ZXv/xZSU5lNPlZoUdgRh0HuLKewJSy1N2mWoILgrxO/EjmA/q/gQZTb+siuYQZJKi
	 x41KIni/PI75WYY4nw/12XGtsrQmEuvw6cnOKdx/zh7aXPYvAHc1Oe8lNkXTzqLFNcjMTpDmz2qO
	 YH6bPzF1qn59InXEE3agdfzqF8pduDgtgi6cW1FjoO9DKBedcuR76FfM2EsP50zOnqf1xHDxFJcr
	 j7384jIh0Ng2I2UgdMpZFqtR9dbe6oM1b0d3gXXlK1YlWpDbnv5MorEqgSllPnRJ852ChuRLsDNi
	 mADBBxf19/fYwDBrshwEESyMTOxWpDRdM0+O8KfPcW3OaoyQHkpo5+GEsVxbIJqV3doPvR1SEFq0
	 YGRAcCsTnun14YO4xB5e9zIxK0AXUV1ziVvYhSHpdGpNrDXu2v1T/FHMFqQdQUThVCsHqUcurg25
	 U/pQtgJsOT43pt08U4oJRlmtzp57Bzo8JIpMFV4+k37v1wl9hqJhBACOFezzJV9A05zt/io2KY+I
	 ER0ijo5zGMCXFIglb5QWTL+mkMCiAvsTQFExAVzZIJ6P0G+b8qFg1SDtwwVoU6X7D2l5gC9fDx8e
	 JRi9qK1xlJFcYRe2bimDcJi2lkBKA0XTPY2gNRFsyc2e6v5LRKuxmuAqtHGp3wQSaaQ5VTZQ3z98
	 60v5VL8Pz/JTL0ohQUuLJ983MLKqqFwnygWIjEB+mvKQEVY/pbkxpbHcAZs8DXofKNWdE+3Rw3Qh
	 Xi3qLo1BNSe80BzWfX/2wAeRwsf1wau8TT7S/0QuNmuClhmasToY5jttFcvByjoCckdjwkmwmIx+
	 UzwTX8+q2fSuAQ4ZMqmRscOT4qXgqDnh1H6hW1CajSPo3QIgnefYgIoNr1tzF/+OjRwtj7qNT1B1
	 Z41K3ILaSAJq9z8hi2rAGbw6m9lW3bnVJgO03uhVFkSt1njickYQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: kingdix10@qq.com
To: manivannan.sadhasivam@linaro.org
Cc: bhelgaas@google.com,
	kingdix10@qq.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	marek.vasut+renesas@gmail.com,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: [PATCH v2] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Tue,  7 Jan 2025 08:59:06 +0800
X-OQ-MSGID: <20250107005906.698984-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250105165324.swmtt4qedut5eald@thinkpad>
References: <20250105165324.swmtt4qedut5eald@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-01-05 at 22:23 +0530, Manivannan Sadhasivam wrote:
> On Sun, Jan 05, 2025 at 01:57:51PM +0800, kingdix10@qq.com wrote:
> > From: King Dix <kingdix10@qq.com>
> > 
> > When using devm_request_mem_region to request a resource, if the
> > passed
> > variable is a stack string variable, it will lead to an oops issue
> > when
> > eecuting the command cat /proc/iomem.
> > 
> 
> Is this your observation or you saw the oops? If the latter, please
> include
> the relevant log snippet for reference.
> 
> > Fix this by replacing outbound_name with the name of the previously
> > requested resource.
> > 
> > Signed-off-by: King Dix <kingdix10@qq.com>
> 
> Also, please do not send next version as a reply to the previous one.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > ---
> > Changes in v2:
> >   - Fix the code indentation issue.
> > ---
> >  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar-ep.c
> > b/drivers/pci/controller/pcie-rcar-ep.c
> > index 047e2cef5afc..c5e0d025bc43 100644
> > --- a/drivers/pci/controller/pcie-rcar-ep.c
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
> > @@ -107,7 +107,7 @@ static int
> > rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
> >  		}
> >  		if (!devm_request_mem_region(&pdev->dev, res->start,
> >  					     resource_size(res),
> > -					     outbound_name)) {
> > +					     res->name)) {
> >  			dev_err(pcie->dev, "Cannot request memory region %s.\n",
> >  				outbound_name);
> >  			return -EIO;
> > -- 
> > 2.43.0
> > 
> 

This is only a potential issue that I found while analyzing the code.
When cat /proc/iomem is executed, the r_show function called, it will 
access the name parameter of resource. Specifically, if a variable on
the stack is used when calling devm_request_mem_region, it will lead to
an oops problem.


