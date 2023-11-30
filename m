Return-Path: <linux-pci+bounces-288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCED7FF0FF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDAAB20B68
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4147A7D;
	Thu, 30 Nov 2023 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwI0C9xD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59103CF
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 05:58:02 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c6291767ceso372833a12.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701352682; x=1701957482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7tlrCJTKDmqu912ndC8IMzjGhq0KkbQ5XUiGAU1JLY=;
        b=xwI0C9xDafuTlFW5/Qy3T2pcftqEmCvWNSc+55HkvbnYyNgkB/U6cwUjxkxRlxLsFW
         vVo8pnlyOeFnyeJ+zDeuodkOXZsQPpsr1mDZv1qowB6efV2cTPNpTqclR010eFA7UkUz
         I+DaX5MVeYtHou8+DUMJOPZPZw1MUC/1SwbiiQYF+e8S0BSd2XVobW/ELzd92V1P2aWk
         4D8l2Mk8mU8LpoOZd/+N0ltqJClgP31H96RSv0p08DhFz+2AMiPKMyLjwPR2XCssfNIX
         cJZSKS+P68FqBTHSpAgJITU5Zpr4OZ8R6160M77wENp2p0i0615UUv2g6d0Q4TYG7zEy
         jtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352682; x=1701957482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7tlrCJTKDmqu912ndC8IMzjGhq0KkbQ5XUiGAU1JLY=;
        b=q8liVr/yp5b3Vksym3Gp2ytrawwBy1rf8vtqTvln0k0y3eyKiSEQLQipzeUrUeptAm
         eDOycfdBf3wHbXO64gEJ5kF3QRweniblR62FjRwJ1r0NTwERk2p04cGCTXOD2R0NLwDq
         9OAVs4cJ8BVTNaHI3FHzt2x6QREaEF+rqKEPXpjN9pzWNIrWYp66fmBWltnvyZUqyjs6
         kwlUi8fRjKEoBlQgMxHrUxULwhIQso4mm3G7DKXEKcZP7dN3QRSmagDePZRRyT2vRdml
         aZL38C1NSfUJRwdfWXEiNGToQlu0tzRklCEEurmm7jhfFnh1rVtz+SpCE5pVQIN+Vfov
         /wLA==
X-Gm-Message-State: AOJu0Yzucyya+tXgyfkJapkeFtsGy+ENqY0jY0/GyddeoAH5K0murEYr
	rREiQtj0SGdOP3SWBhOFAOny
X-Google-Smtp-Source: AGHT+IFmvRgD+nSBAXSNBctVx3fCru60TMu5sIVpLM5thAGFppFn2zg5u0m2fcA/KixZyYuJ8lomYQ==
X-Received: by 2002:a05:6a21:3283:b0:18b:246a:d43d with SMTP id yt3-20020a056a21328300b0018b246ad43dmr28457008pzb.15.1701352681654;
        Thu, 30 Nov 2023 05:58:01 -0800 (PST)
Received: from thinkpad ([59.92.100.237])
        by smtp.gmail.com with ESMTPSA id m127-20020a632685000000b005c606b44405sm1263184pgm.67.2023.11.30.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:58:01 -0800 (PST)
Date: Thu, 30 Nov 2023 19:27:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20231130135757.GS3043@thinkpad>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon>
 <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad>
 <ZWhwdkpSNzIdi23t@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWhwdkpSNzIdi23t@x1-carbon>

On Thu, Nov 30, 2023 at 11:22:30AM +0000, Niklas Cassel wrote:
> On Thu, Nov 30, 2023 at 12:08:00PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Looking at this issue again, I think your statement may not be correct. In the
> > stop_link() callback, non-core_init_notifier platforms are just disabling the
> > LTSSM and enabling it again in start_link(). So all the rest of the
> > configurations (DBI etc...) should not be affected during EPF bind/unbind.
> 
> Sorry for confusing you.
> 
> When toggling PERST on a driver with a core_init_notifier, you will call
> dw_pcie_ep_init_complete() - which will initialize DBI settings, and then
> stop/start the link by deasserting/asserting LTSSM.
> (perst_assert()/perst_deassert() is functionally the equivalent to start_link()/
> stop_link() on non-core_init_notifier platforms.)
> 
> 
> For drivers without a core_init_notifier, they currently don't listen to PERST
> input GPIO.
> Stopping and starting the link will not call dw_pcie_ep_init_complete(),
> so it will not (re-)initialize DBI settings.
> 
> 
> My problem is that a bunch of hardware registers gets reset when receiving
> a link-down reset or hot reset. It would be nice to write all DBI settings
> when starting the link. That way the link going down for a millisecond, and
> gettting immediately reestablished, will not be so bad. A stop + start link
> will rewrite the settings. (Just like toggling PERST rewrites the settings.)
> 

I got slightly confused by this part. So you are saying that when a user stops
the controller through configfs, EP receives the LINK_DOWN event and that causes
the EP specific registers (like DBI) to be reset?

I thought the LINK_DOWN event can only change LTSSM and some status registers.

> 
> Currently, doing a bind + start link + stop link + unbind + bind + start link,
> will not reinitialize all DBI writes for a driver.
> (This is also true for a core_init_notifier driver, but there start/stop link
> is a no-op, other than enabling the GPIO irq handler.)
> 
> What this will do during the second bind:
> -allocate BARs (DBI writes)
> -set iATUs (DBI writes)
> 
> What it will not redo is:
> -what is done by dw_pcie_ep_init() - which is fine, because this is only
>  supposed to allocate stuff or get stuff from DT, not actually touch HW
>  registers.
> -what is done by dw_pcie_ep_init_complete() - I think this should be done
>  since it does DBI writes. E.g. clearing PTM root Cap and fixing Resizable
>  BAR Cap, calling dw_pcie_setup() which sets max link width etc.
> 
> 
> 
> I guess the counter argument could be that... if you need to re-initialize
> DBI registers, you could probably do a:
> stop link + unbind EPF driver + unbind PCIe-EP driver + bind PCIe-EP driver
> + bind EPF driver + start link..
> (But I don't need all that if I use a .core_init_notifier and just toggle
> PERST).
> 
> Of course, toggling PERST and starting/stopping the link via sysfs is not
> exactly the same thing...
> 
> For me personally, the platform I use do not require an external refclk to
> write DBI settings, but I would very much like the HW to be re-initialized
> either when stopping/starting the link in sysfs, or by toggling PERST, or
> both.
> 
> I think that I will just add a .core_init_notifier to my WIP driver,
> even though I do not require an external refclk, and simply call
> dw_pcie_ep_init_complete() when receiving a PERST deassert, because I want
> _all_ settings (DBI writes) to be reinitialized.
> (If we receive a PERST reset request, I think it does make sense to obey
> and actually reset/re-write all settings.)
> 

No, you should not add core_init_notifier if your platform receives an active
refclk (although my heard wants to have an unified behavior across all
platforms).

We should fix the DWC core code if you clarify my above suspicion.

- Mani

> A sysfs stop/start link would still not reinitialize everything...
> I think it would be good if the DWC EP driver actually did this too,
> but I'm fine if you consider it out of scope of your patch series.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

