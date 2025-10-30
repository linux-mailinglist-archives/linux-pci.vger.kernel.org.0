Return-Path: <linux-pci+bounces-39789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E629EC1F6FC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 720A54EBC88
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FC3354AD8;
	Thu, 30 Oct 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D7faxU3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF20350D74;
	Thu, 30 Oct 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818464; cv=none; b=d10pNxRh2TfMoNO9A20WXvX8Fdob+TXIPS4IPypeh/HfqgYRrFCK8s9XtpAOd84DF+hQj83UhTBzIXpPaoD36ikMZJus4Mmkf5+wHeHBiUm6kbOV+8dVtI74ifMZaxKBCnNFcvZ/L+/QPSw/32D9oo4hzPI6Vxbo0iidN8kMuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818464; c=relaxed/simple;
	bh=8z2DPsxRfU7/x/3wxyDVReRDq9qq0yZeP1k+PdqwnXg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URonLUTnUjYPKhYfWOq2r6648DYaILB7h+QbUdg55SAkzqbRLFxDCshVKW50mGNiB3869dQ2mxJcyZ0O/Dgil1imvOH/ByxM1ZTMNcHbobzGyIblr+B6ZlBJ+I/9wUkhOUE8ejmfaNG8j4fZVwSA51PI0VSEbTYguXJNL9FnqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D7faxU3P; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=juOtsw+XKXPdwDGMXWQfaBt8GPcPrObp5r2IzcEKJAs=;
	b=D7faxU3P5QktFdurjwp3E0G4X2lKyA6nan83uV2enABhH3xdLSRVWKnyiEsUmyjSpxDPi/gAu
	5US+NpL5CPAQopObhEVmxCjSHAjeLBl0mq7xwHJQWGEClmUDZXVC9pDBe7TfgMllEvJ1ff1XJSt
	pS2MUj+RAS3uwLidb0hpONk=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cy0414f4cz1P6gW;
	Thu, 30 Oct 2025 18:00:49 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxzzf4KlBz6M4p0;
	Thu, 30 Oct 2025 17:57:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A6BEC14038F;
	Thu, 30 Oct 2025 18:00:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:00:53 +0000
Date: Thu, 30 Oct 2025 10:00:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 06/12] coco: host: arm64: Add RMM device
 communication helpers
Message-ID: <20251030100052.00005c65@huawei.com>
In-Reply-To: <yq5ay0osd9yb.fsf@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-7-aneesh.kumar@kernel.org>
	<20251029183306.0000485c@huawei.com>
	<yq5ay0osd9yb.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 14:48:20 +0530
Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> ...
> 
> >> +		/*
> >> +		 * Some device communication error will transition the
> >> +		 * device to error state. Report that.
> >> +		 */
> >> +		if (type == PDEV_COMMUNICATE)
> >> +			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> >> +						 (enum rmi_pdev_state *)&state);
> >> +		if (ret)
> >> +			state = error_state;  
> > Whilst not strictly needed I'd do this as:
> >
> > 		if (type == PDEV_COMMUNICATE) {
> > 			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> > 						 (enum rmi_pdev_state *)&state);
> > 			if (ret)
> > 				state = error_state;
> > 		}
> >
> > Just to make it clear that reg check is just on the output of the call above.
> > If we didn't make that call it is definitely zero but nice not to have
> > to reason about it.
> >  
> 
> Some of this is because follow up patch adds more details there. In this case.
> 
> 		/*
> 		 * Some device communication error will transition the
> 		 * device to error state. Report that.
> 		 */
> 		if (type == PDEV_COMMUNICATE)
> 			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> 						 (enum rmi_pdev_state *)&state);
> 		else
> 			ret = rmi_vdev_get_state(virt_to_phys(host_tdi->rmm_vdev),
> 						 (enum rmi_vdev_state *)&state);
> 		if (ret)
> 			state = error_state;
> 
Ah fair enough I missed that.

J
> 
> 
> >  
> >> +	}
> >> +
> >> +	if (state == error_state)
> >> +		pci_err(tsm->pdev, "device communication error\n");
> >> +
> >> +	return state;
> >> +}
> >> +  
> 
> -aneesh


