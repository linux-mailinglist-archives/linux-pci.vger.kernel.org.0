Return-Path: <linux-pci+bounces-16871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C739CDDC2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE5CB2389B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77741B85F6;
	Fri, 15 Nov 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMzID8m6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA11B3948
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671475; cv=none; b=cLUsiZsq6gLuJeu5wot5c7H3BJkUCjqBecrbprxZn69ypvTww4298PpcHPGfOxVox5Ot9GxPjz4Hm32Ry4t3GjSad2ioCutoXf28NOmKqxjoObD5QBH7O94AyTjvcQxE/RVjalW3yTEwEDdfwn9xArPk7xovEyzhWhquhrmDXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671475; c=relaxed/simple;
	bh=sZdR9W40s3IqCSaLvH1Sa+P9DP69302jesYf4sRn+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgkZ303mfg/vVHsdkUFil6PeDE45O6gYQSehB/kE18MoBsBpgP7QCIQGl5V5F6nh8ziu9PNes9BdKoml+hBedPrrMPE0cwKlWP1pmcFvQFXOgVBJHyNTnEmDOwj+eBXz5AE+BqR21bzzHIFilhtHvO9e9tCKgoXSvt6km3XHsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMzID8m6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so1099393a12.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731671473; x=1732276273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qz4zjxYN8EsB1sVFFLtbfHvdqNPBMDPqRlMkCvciKQ=;
        b=vMzID8m6K3DMLchGm5z3M2nR5eVE8wC23baG//7YndEYtxnDR+Zh7u8NGd4uw5yNEF
         vjxZDAZWxpCjbro5IEog6XXVzpQ1S+f1LlCyyhBlB1iG4XkQqMUjUp82BK2mjbHU6u0f
         7+9FUPwlhuj+TQabd/D17p73qCHrSacflcYMpd/uSexbFL+WDcUvwZBfUlxXwKG+uYHf
         Ocd/2jyjGUIPmZRFl6smiLW4yeEK3VdFEKLzcdElxKV1IhdsX7MlUcvk2atcPXnWHC8y
         Xv1UaHOuQ9VT9vYSkv0kgm5xBQo6Bp+olbwLGtvyX6blL6Qfh3El0WKoFquEpFHgNcz/
         vumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671473; x=1732276273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qz4zjxYN8EsB1sVFFLtbfHvdqNPBMDPqRlMkCvciKQ=;
        b=ooaosFj3JGxJZwRmGWEG1CTnsffFOgB8zrq72vJZq4pjgehdK51S/Iaw5CkAit42HO
         /ZUDuAM3IRCd1nN752NgEn+0yBB9aw81jrIvGVT29nWMK73hb2B9hvNe6DITl4M1ep9W
         /1yYY8PyEC+V2KqC9fFrJ03OqmicXwCyyKqkDn3e8334OPiWHmInU8PI5meBiPTfs2OV
         fP1B8Ww9/1V50Za3ISQO5zBbVNmQXCDqwaTYywmrOaDPG5bh8nMMtTfJBJqN6mHOjHT3
         vdg+TXqX4lo7gwpDlIagevUuc6VRUdDbw3+XAWCmP8A6oB+mCZR81Z77+jEAz1Y1hFER
         c4tw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4kdJPgl8/U0NqN2rZ3ihNQf1hi9OVmencftfgBf/Ng9LjOdc588lwnbztw93jc1GQna/BnKohUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfwso4fvpgYPJ078Z4zoqJNMveHjYMjQmPe4CB9quwKK4RwOH9
	b3HglE3sgQ6mkH5n5KdhU0Jl+m3qmlaPX0ZXx5RlgOrEdP3dCEbPflR+LV1HTQ==
X-Google-Smtp-Source: AGHT+IHpT8ZeMKed/s/RPDlK9VLqV5kI+HNUu4iV8muOdZoUPUkSFT36NhvQLuLYGoL5BZzy2K3vgw==
X-Received: by 2002:a05:6a20:3946:b0:1d9:1045:3ed5 with SMTP id adf61e73a8af0-1dc90b23572mr2838926637.11.1731671472789;
        Fri, 15 Nov 2024 03:51:12 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eea1asm1200047b3a.28.2024.11.15.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:51:12 -0800 (PST)
Date: Fri, 15 Nov 2024 17:21:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] PCI: Add new start_link() & stop_link function ops
Message-ID: <20241115115104.hsa4udzkhhavahgi@thinkpad>
References: <20241112-qps615_pwr-v3-3-29a1e98aa2b0@quicinc.com>
 <20241112234149.GA1868239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112234149.GA1868239@bhelgaas>

On Tue, Nov 12, 2024 at 05:41:49PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 08:31:35PM +0530, Krishna chaitanya chundru wrote:
> > Certain devices like QPS615 which uses PCI pwrctl framework
> > needs to configure the device before PCI link is up.
> > 
> > If the controller driver already enables link training as part of
> > its probe, after the device is powered on, controller and device
> > participates in the link training and link can come up immediately
> > and maynot have time to configure the device.
> > 
> > So we need to stop the link training by using stop_link() and enable
> > them back after device is configured by using start_link().
> 
> s/maynot/may not/
> 
> I think I'm missing the point here.  My assumption is this:
> 

First controller driver probes, enables link training and scans the bus. When
the PCI bridge is found, its child DT nodes will be scanned and pwrctl devices
will be created if needed.

>   - device starts as powered off
>   - pwrctl turns on the power
>   - link trains automatically
>   - qcom driver claims device

QPS615 driver will claim this device not controller driver.

>   - qcom needs to configure things that need to happen before link
>     train
> 

QPS615 driver needs to configure the switch before link training. So at this
point, it stops the link training, configures the switch and starts it again.

Patch description could be improved.

- Mani

> but that can't be quite right because you wouldn't be able to fix it
> by changing the qcom driver because it's not in the picture until the
> link is already trained.
> 
> So maybe you can add a little more context here?
> 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  include/linux/pci.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 573b4c4c2be6..fe6a9b4b22ee 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -806,6 +806,8 @@ struct pci_ops {
> >  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
> >  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
> >  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> > +	int (*start_link)(struct pci_bus *bus);
> > +	void (*stop_link)(struct pci_bus *bus);
> >  };
> >  
> >  /*
> > 
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

