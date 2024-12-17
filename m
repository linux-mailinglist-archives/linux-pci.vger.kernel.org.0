Return-Path: <linux-pci+bounces-18641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7219F4E62
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889BC7A884A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45B1F6692;
	Tue, 17 Dec 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pha0mVgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A561F667B
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447045; cv=none; b=DqpwKzeZIsnq1t9Irt6DHMFdk3BVoiL6zD/fwxLOuGfW8RoNMWnLjfm6rVYpkBg8VaoZDYzNt3eM+03fAo42LdfBQ0YqHA7GvJP1E561XsS4zet83reA5LEL2r6c4j/S2WodKvDf+bS0i21Uc8Ro7kngjdLu+Ra+/tRTkQ2DUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447045; c=relaxed/simple;
	bh=ZbUaNb3EeOq38wPTGMjiF7auqJAwjbXnxnlKi2+F84E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb0R6aIUZA6cf+PXsOIR9QBFTQZLD8NemHyJVGIWZumYu+vD6WqownkLJtOgUCmjZMS8JgemEwIyzWWYSfAlPKixZIrRKPXTWJr4rmI6WPoDGk/en3D6BZEb5RzxBeCjEj4FKhXLNwecqLK4D+GNpZ7++y10fHOpNj5BO1S5sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pha0mVgD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216634dd574so31283605ad.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447043; x=1735051843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWlyGLT1JwLt22qsbr4SWZ1DntkrQPILyyQ7U2P+kkY=;
        b=Pha0mVgD4Rgj/Lyb6LKZ68WnJnpybLlzvYz/Q4ByIioxXTtVCkFcOM5j3NwARZCpsv
         6OeDaGSaiDzMOqd3Ell1zO7EB7Okkr67AkpqbfSzHnsSHrvNx5DCKGsZZT/8QHC67DYs
         hV3E+KX1y1gxNSJDDWvrUC7LxZebwHtsI4+LOOlcNjY0Ad3Dc4rwck3l7KZKcwPI8pjX
         Ctls8em5dBUZ6kizBR3VyVKQMrn/FWOt10UUz7ax6a5VQo+txV5lRElPDJ6nFxqFcEaj
         QJ7i6Ia9Of0fLUmTiYkIl9lBhW1UXPmqLTWN9+6i5tf60IfLEgOkD/7hnAvmw2f7qlAA
         hh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447043; x=1735051843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWlyGLT1JwLt22qsbr4SWZ1DntkrQPILyyQ7U2P+kkY=;
        b=TVslBqCzQzGfRdlnuo6aRzIeyQSvT/C8CfjjB5a7vjYZlv7ucP/NqS/flH9eDaIbpF
         QZB0ZIKArYk4mWeWvrZgV6M3aj7lUAm/BsEV/WiEC0OT7K5LDuBzSm8/f46M6VxCZHs6
         +5uUN0K9ZgITsn0nM2Ghk59PV1zeLryyT+1NnsFz315VY2dMNxEVRfGK118FImM9jVXk
         IudQEqkIExj+UvXKHfW9zkplry/E3DtQyQEtSikNvjI6jec8vlZaN2AYHQFteEfdgj9h
         0sCBohJYh3Es0XFM1zvjhkUMgmyg34cHT+uHcUZuSg1W2YQb5jbblLZhsUzREx2tFeSo
         QZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW3g1JDFh6cf0xz01RVWEEAIrPwDRylrxuTp5NvT9rZ8QazJuAELS30VUDaam6+izJoealPGwjZfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeo5XiU41zqrTbIWAOUsoHzfoZnt6SBTfsQhE08zYNOwY3dUrZ
	BgCWx6hueB9ySPN9dE+EZxE9KS4maqErBNdeaQdpIvjKtzpZsZQJfsVEsIV3ug==
X-Gm-Gg: ASbGncsSPFS+S+QwAee5iXhElbvpEw4+JWM07aZ2cGJiC1W7065mUg64p0FfZ1ToX4E
	onbLs+AqJKNt9Kmc0aprY2YJzvPlnIbtaScEgAMyhpy0jmMMv6Mz/2ixIksQhdTlnAuQkCQml77
	NtonSq7A0Uvges9rohpyrBlSNIYKKZqBOUwxWzXBSWZM3fe5cHbbweFHj4hi1jLVCLXJFWvj8bo
	koYfHNHhrCbP7k84xgtL+RQKzO9/Go4N03/kyvd9mSohBUQvdPumPQjLPrdRmXVaU9u
X-Google-Smtp-Source: AGHT+IFDViMZlPC0m+oxxZvBpRPL70m/brWbrYzW/ZKuaCPt2qJLSqTvp50LiJFnWq39M8/NKSm20g==
X-Received: by 2002:a17:903:234d:b0:215:5240:bb3d with SMTP id d9443c01a7336-21892a416f2mr237981565ad.42.1734447042791;
        Tue, 17 Dec 2024 06:50:42 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc165sm60475035ad.88.2024.12.17.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:50:42 -0800 (PST)
Date: Tue, 17 Dec 2024 20:20:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Message-ID: <20241217145035.xqfl4yp3atpgqzth@thinkpad>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>
 <Z18Pmq7_rK3pvuT4@wunner.de>
 <20241216051521.riyy5radru6rxqhg@thinkpad>
 <Z2F5Oph2o8o_LiZc@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2F5Oph2o8o_LiZc@wunner.de>

On Tue, Dec 17, 2024 at 02:14:34PM +0100, Lukas Wunner wrote:
> On Mon, Dec 16, 2024 at 10:45:21AM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Dec 15, 2024 at 06:19:22PM +0100, Lukas Wunner wrote:
> > > On Tue, Dec 10, 2024 at 03:25:24PM +0530, Manivannan Sadhasivam wrote:
> > > > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > > > index 2fb174db91e5..9cc7e2b7f2b5 100644
> > > > --- a/drivers/pci/pwrctrl/core.c
> > > > +++ b/drivers/pci/pwrctrl/core.c
> > > > @@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
> > > >  						   struct pci_pwrctrl, work);
> > > >  
> > > >  	pci_lock_rescan_remove();
> > > > -	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
> > > > +	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
> > > >  	pci_unlock_rescan_remove();
> > > >  }
> > > 
> > > Remind me, what's the purpose of this?  I'm guessing that it
> > > recursively creates the platform devices below the newly
> > > powered up device, is that correct?  If so, is it still
> > > necessary?  Doesn't the new approach automatically create
> > > those devices upon their enumeration?
> > 
> > If the pwrctrl driver is available at the time of platform device creation,
> > this is not needed. But if the driver is not available at that time and
> > probed later, then we need to rescan the bus to enumerate the devices.
> 
> I see.  Sounds like this can be made conditional on the caller
> being a module.  I think you could achieve this with the following
> in pci_pwrctl_device_set_ready():
> 
> -	schedule_work(&pwrctl->work);
> +	if (is_module_address(_RET_IP_))
> +		schedule_work(&pwrctl->work);
> 
> Though you'd also have to declare pci_pwrctl_device_set_ready()
> "__attribute__((always_inline))" so that it gets inlined into
> devm_pci_pwrctl_device_set_ready() and the condition works there
> as well.
> 

I'd prefer to skip the rescan if the pwrctrl device is created and let the
pci_pwrctrl_device_set_ready() initiate rescan once the device is powered on.
This way, we could avoid scanning for the device twice.

> I'm wondering whether the bus notifier is still necessary with
> the new scheme.  Since the power control device is instantiated
> and destroyed in unison with the pci_dev, can't the device link
> always be created on instantiation of the power control device?
> 

I did move the devlink handling out of bus notifier callback with commit,
b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI
client drivers").

The bus notifier is only used to set 'of_node_reused' flag to indicate that the
corresponding DT node is already used.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

