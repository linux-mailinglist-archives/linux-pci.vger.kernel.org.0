Return-Path: <linux-pci+bounces-12925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6E97033C
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025FA283959
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7915FCE7;
	Sat,  7 Sep 2024 16:56:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277915CD58;
	Sat,  7 Sep 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728175; cv=none; b=hsQfDXYqBssFuIkDe4pV9dCvCUZsz37S9VOw6JArLFUXTG7w4OlyqpQFQ+X6pGd5DZ457yyCE/DUWfP3/jaRlcalSitqEC1FuUMWp1RohwqUg6PZDpE7m6H5syZB6E6oJQQKxac2hR5SyZa3J2uwsV/8XkAgx2r1GeSLHx1OgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728175; c=relaxed/simple;
	bh=0LZrFiFUhWq9Xr12CP/gaLrLEt3Cuu8ybH/pfwjcGVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAOPTOA7vlfRjWCXhkDxhNxNcn0Ul9Hxa3NbYhy5ESPKYW26oxSnB4CUHwhCahKuRE/YeeZykM9Dst/NLCAOp+loiCulkgr7Innk/xeZbI2B9eizQQRqxTwzZ+WWHId9N+xjW1xCs1Ekcdsg0eSJbZ5nwsyJ5F62/x8MKIkY+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so2179658b3a.1;
        Sat, 07 Sep 2024 09:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725728173; x=1726332973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OEjKisGyZpikcENOe0EKCmxLKuxWqz4sfdKvQEqRUA=;
        b=fkUO136lmxCopJfshmSFIDCbbMpdA9+QC1k9vxlRKq0+ZOZc6p/qB+JvPKgAxxvShn
         U1HRZheFvTh72H5+ODhkEQbyyd9IFENHwAqM43qJXVI0gJkWLLN34nprHpSQ31kYTBiP
         FZy0a70J5nzXDE1fDSZFw7/w7imbG/nrepuDm3eeaaAqMX+orRNqjnUR66fyhT4JvR2g
         j4OjCCUSCnUMgV9pVgBIcISsrwjA58zGGjL56DkzJGuy8qpGO6nU0LMYc/gDp+JoYCMq
         lPU8JeYu1Po1GciqR+29zFL3cbUmSdx+SZy3HC+k32cHdX3RXeWMPnwQX7QBORkJH//i
         nLMA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxm9Jp0fr0CX3Twya4h0ZjlRIamTiXzqynbbmuAdmcL4oYh6ay3U8yx07j1oivVcQctI2SCKk2sVX@vger.kernel.org, AJvYcCXbZ4JLVcvxdId2ozcMs4CiLsFQ1twiUd90szFwMfd/IqMK8Wfi8aD8/bOa90I0Xygo84DJq/98S7XWD3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruVj6InkEiaTFusBmtahIYaj/GkpOHdiAYbuW6MJ7apkMUuCi
	OzWEgYV4wgKGXBUpOnbmhY12CSMzWWkqU1kWa3dENRWFODr1j5Ek
X-Google-Smtp-Source: AGHT+IFhnEfqx9zlWtZDUEoXKA5kpIizfxwG/lM8NfgGOt5YnZlGPstyfe4XCWn8XKWtfokoFsEJlQ==
X-Received: by 2002:a05:6a21:9201:b0:1cf:2d2f:3749 with SMTP id adf61e73a8af0-1cf2d2f3849mr2738865637.32.1725728173380;
        Sat, 07 Sep 2024 09:56:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823736c78sm1029199a12.3.2024.09.07.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 09:56:12 -0700 (PDT)
Date: Sun, 8 Sep 2024 01:56:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: jim2101024@gmail.com, nsaenz@kernel.org, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next V2] PCI: brmstb: Fix type mismatch for
 num_inbound_wins in brcm_pcie_get_inbound_wins
Message-ID: <20240907165611.GA238693@rocinante>
References: <20240907160926.39556-1-riyandhiman14@gmail.com>
 <20240907164613.GA183432@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907164613.GA183432@rocinante>

Hello,

> > Change num_inbound_wins from u8 to int to correctly handle
> > potential negative error codes returned by brcm_pcie_get_inbound_wins().
> > The u8 type was inappropriate for capturing the function's return value,
> > which can include error codes.
> 
> I squashed with the current code on the controller/brcmstb branch, see:
> 
>   - https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/brcmstb&id=ae6476c6de187bea90c729e3e0188143300fa671
> 
> And credited you via the Co-developed-by tag such that you get credit for
> fixing this issue.  Thank you, by the way.
> 
> There is no Fixes: tag as this code is not yet merged into the mainline.

For the record, I would prefer if we went with Florian's first
recommendation per the following message:

  - https://lore.kernel.org/linux-pci/159c5fcf-709d-42ba-8d45-a70b109fe261@broadcom.com

To clearly separate errors returned from the value being updated.

Albeit, this is fine too, especially as Jim expressed no opinion either
way regarding his preference.

	Krzysztof

