Return-Path: <linux-pci+bounces-17049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429A9D1452
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 16:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA1B29960
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CE1A0AF7;
	Mon, 18 Nov 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xp9rGTLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2E20309
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941909; cv=none; b=D11tcKfXYhit0j5WgBYnPvePvUG3jyklwkHovp7oetv+vrmk5vABIXB5ES2ak1rrUCvfvj9uxFLUpQYhh1LcC5cwpM7cvbGqGjE9QPsyB7ZEDSBQi4vGOpbTGs3SUMfngxS8jKLUiA23GpDZ6S9mkhKSE4tnsZM3uL47WRfl7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941909; c=relaxed/simple;
	bh=TWzvGZ8KRSmRHzydZETL80z6/QZ2aw2ZYkM4Nl2AVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggnl2Y2O3Eo5+oolxu7jk/IeOqkogCnPL/NyI+gYdQ6R8OwAZLVg9mEdi4c+F6tw8m3y1f4nPzeKhujy3+SuMvRVKV3iHpZDJKi53Sc1+IX+htgbOH3DNwYNNSEeBbgyZzyc+vJ80JXoIzGyDEylb306wD9rVMMDG1twaLFHgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xp9rGTLn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so3097905a12.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731941906; x=1732546706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Kj40amW5IpporSjQ73hgk+ubBMNelSpX7cTHNX0nDY=;
        b=xp9rGTLnyVA35a576MzaiHUZXCxCl1zD8++LP8jzDpYp3Q+u8s80tRqymsT1DimmKR
         wSLHWnaEBfkBGfigUhLFIst7hQYMRZllOoKxfYBlxx7kMaAF/cdbdAAREjQPSW5QbyuW
         zEKiBtMlNcItd+x6HNnFlXlCbQGAWqsG41hd7vdMHidCIfewwbcsYtTzg6QXQprDQkMD
         cATV1JWv8b1QtQBJBVk5/M0Oh9EkN7Ukeyp+VQFGr4L9bUpozmD+U1/CGrNPaBeq5Xo9
         HdMA7iBCRUUREPOvHzazsNnuO4RpYI74AW7T5YatS8056hK83SEIkYHodRdXxmg9RTD0
         wBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941906; x=1732546706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kj40amW5IpporSjQ73hgk+ubBMNelSpX7cTHNX0nDY=;
        b=eqfnQ+r3jmKiCi8twTmY0wO2GJ0Py/0mzUYu6JXmkl1TCOQKcCuERgJuvgI0CnHlfT
         qSSFvg1IKpOexJ/6onYnWhukHZ1KXomNEj+HHBgS91UcT+EhN+EQ3wNsvgyq4PLadvgT
         Rr8UzTSXcaH1eKbkoKJli9JF6MSjV9aPW2Yma5zzyD/fQgpqvLBmh86j1bFPuMczsY7M
         06aMdWHgasIorJivlND4yFC5iOhkNwWr8XHm6Z5NJ7bztoZT3CXVFS2yKUax+dGx01HU
         NOawQEUTeljqxehohX5HLuEFvAv1H7/yvlQNPeNr5OPwHr0n2O/vZURP6aeLbdEYyuwQ
         ZcIw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVkT4+U1gcCuYcVTg1iquLlGAB/+z8IIKc1GfzeVGJ4VnRsy4GTWd5BEUeSWibvY9tKNYY6QZHIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+4ggkQ60vun03DUQHZ/3GYAIKggU++0hQz6TqZQ8R+gR58V9
	3CpAVwx+rHwzdjvbxKN8R9QAdKc8NWnXzXpEPzTCoihRFjarCQwFuEagdW95aQ==
X-Google-Smtp-Source: AGHT+IFXhxjuxnpcBK6VkRM8ka4xfCsVzl6RCq9DZi8mELcnE7vPbPlemi6MxwH3EwSL+aB5tXXoZQ==
X-Received: by 2002:a05:6a21:7881:b0:1db:dbad:ce3b with SMTP id adf61e73a8af0-1dc90b60450mr18251249637.23.1731941906610;
        Mon, 18 Nov 2024 06:58:26 -0800 (PST)
Received: from thinkpad ([36.255.17.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5c0csm6291226b3a.164.2024.11.18.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:58:26 -0800 (PST)
Date: Mon, 18 Nov 2024 20:28:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241118145820.2ecu5hzb2r5ygjvi@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241118125817.GA28046@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118125817.GA28046@lst.de>

On Mon, Nov 18, 2024 at 01:58:17PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > PCI core allows users to configure the D3Cold state for each PCI device
> > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> >
> > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > during system suspend if the user has allowed D3Cold for the device.
> > Existing checks in the NVMe driver decide whether to shut down the device
> > (based on platform/device limitations), so use this flag as the last resort
> > to keep the existing behavior.
> 
> Umm, what?  The documentation of this attribute says:
> 
> "d3cold_allowed is bit to control whether the corresponding PCI
>  device can be put into D3Cold state.  If it is cleared, the
>  device will never be put into D3Cold state.  If it is set, the
>  device may be put into D3Cold state if other requirements are
>  satisfied too.  Reading this attribute will show the current
>  value of d3cold_allowed bit. Writing this attribute will
>  the value of d3cold_allowed bit."
> 
> Which honestly already sounds rather non-specific, but everything but
> a mandate for drivers to act on it.
> 
> The only place currently checking it is pci_dev_check_d3cold in the
> PCI core, which is used to set the bridge_d3 attibute.
> 

Yeah, it is pretty much used internally up until now. But the attribute looks
like a close match of what I could find for this usecase and that's why I used
it.

> So blindly using it in a driver to force a different PM strategy feels
> completely wrong.  Even if the attrite should have that effect it
> needs to happen through a well documented PCI or PM layer helper and
> open coded like this.
> 

Ok. I'd like to get some feedback from Bjorn H (PCI maintainer) about using this
attribute before moving forward with a helper.

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

