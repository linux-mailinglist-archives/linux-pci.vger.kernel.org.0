Return-Path: <linux-pci+bounces-2321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D3831D48
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641EE285220
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB562C194;
	Thu, 18 Jan 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQc3e6NI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B128DDA;
	Thu, 18 Jan 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594381; cv=none; b=Kce6Iyj1aiNQF8ekBQg9YlqEUvwlOovrwu7Fh2eFSKKOhzoxokmtqrK1XP71T4jlnPCLGc9pwuUAQJECM6VDWYH/FWwKkvbWsehH5sAbfCf79nfXqhKoGJRgQtQlGjdHzs6KqG7e0mHilGj+WqYXa3G8uVXU1iMGc1fytKkAHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594381; c=relaxed/simple;
	bh=8NoStMZp0TB8q3jrITsXs6s0yhquDXW9LljJq0jQBeg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=o1pIIkpuVOJyJiQfEEnI9wtX/M5BCMcD23uNSXKFWbexYu3xtOeKIomDCRkEVPUrrPXW5hwkHHy2CFOZrm8XZrpFkygn2F6Eg0AvRyRgMi3Z/aNhRBbzF0av4nxBxKGkzStSLc2OvhJIe1t/1pP+704rlmkMN3N46OV5s0SWXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQc3e6NI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6daf694b439so6974207b3a.1;
        Thu, 18 Jan 2024 08:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705594380; x=1706199180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASbIsDuH6/1Mo4MaDgTuPSwi0dXnfDHc/QyBIdAIL4I=;
        b=KQc3e6NIxPsaVVum9svsy+Qq02eWH/rm2kIWUGzWW+0VguGAONjtbaJqOQrC/2g0vv
         7irJ4m4k4NMbNLvVxoy/4UjQ1NCEaYM5lTsYwhOoY6SqR/J4F7iMbQhPZNiHxuKnRh5h
         FaMReeaD0190nn9lpKyZPVgTdBOewMhlGxnLaT2epmqxX+Mw1jJ+zY1f6YAf62djyCCU
         /Rk59UpZvGbmBTDJ+R+B1DO4/veCdGC2QIS3LVyuqrDy4RckGH9fHVdAsXettIUPOq0m
         2UPLQ5PkBcF0vvd8Pp/jheVKKMj+Z35S/Hnp73On2Cigahcsu2TL8VrUhrrEL8hiXRPq
         8xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594380; x=1706199180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASbIsDuH6/1Mo4MaDgTuPSwi0dXnfDHc/QyBIdAIL4I=;
        b=ndS1mH1YX3AfN+sEzenClYA8gIH44kZhQXrzvS/yyo4ao9ZzUqWOdPItl51EYFI6v6
         Iav+vmsoG/WvH9TI13lfTX4W/biJGb4yBBVDFon/vsJEU7yU+FanmvsAGFVfmQAF7Z6K
         Go5fdDEwuF9TY3S/DsFa4CoehmQkqbY2OC4g6sFCHD6mNcsqshMdDlwx6JYML/DMIOxI
         kcamX/rLbaGe8NgebS5BmMuDb0obKdkS96NIV0ubRaBcWNlVf72r5khDmyJl2hqU/fdl
         FB1ZwnbG3B81TV2rx0Ia1u3t1mDZUFZTPQmo3cpsqS1A0a21XnhwtHF5r8Ea2vJPbVVM
         UJvw==
X-Gm-Message-State: AOJu0Ywm4y50Atif3+CJQ0y5/VIkGbNJ+EJhIwTNJ2htPLFsKFIX8BLu
	4CARz5Rw1HsmZeUfQ8eU0i8oy3Olhovacz6cT/tUtEwgTlXmI7qU
X-Google-Smtp-Source: AGHT+IGEwS/Mpc69BhPwt9Z2PRosCQXyQnkRZBKZCwfbPHKzpJkVR4HsYTm1Zf4G9HUzLxMdnEWb7A==
X-Received: by 2002:a05:6a20:d38e:b0:19a:3b4a:22c8 with SMTP id iq14-20020a056a20d38e00b0019a3b4a22c8mr1167907pzb.14.1705594379663;
        Thu, 18 Jan 2024 08:12:59 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:77ac:1fe8:3f5:523d])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a00214800b006d9a38fe569sm3466683pfk.89.2024.01.18.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:12:59 -0800 (PST)
Date: Thu, 18 Jan 2024 08:12:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZalOCPrVA52wyFfv@google.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>

On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> On 1/18/2024 00:00, Mika Westerberg wrote:
> > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > labeled “removable”:
> > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > {removable} -e {device} -e {vendor} -e looking
> > >    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > >      ATTR{device}=="0x15d3"
> > >      ATTR{removable}=="removable"
> > >      ATTR{vendor}=="0x8086"
> > 
> > This is actually accurate. The Thunderbolt controller is itself
> > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > firmware upgrades to the device.

This is quite interesting take. Does fwupd rip the controller out of the
box to update it? By that account your touchpad is also removable as it
may stop functioning when its firmware gets updated.

> 
> Depending on the consumers of this removable attribute I wonder if we need
> to a new ATTR of "external" instead of overloading "removable".

Isn't this the same thing? From
Documentation/ABI/testing/sysfs-devices-removable:

What:		/sys/devices/.../removable
Date:		May 2021
Contact:	Rajat Jain <rajatxjain@gmail.com>
Description:
		Information about whether a given device can be removed from the
		platform by the	user. This is determined by its subsystem in a
		bus / platform-specific way. This attribute is only present for
		devices that can support determining such information:

		===========  ===================================================
		"removable"  device can be removed from the platform by the user
		"fixed"      device is fixed to the platform / cannot be removed
			     by the user.

Note this "by the user". Maybe we should add word "physically" here to
qualify the meaning completely, but that is what it is. Not that it
disappears from the bus or stops operating for some time because of
firmware updates, but it can be physically detached from the
platform/system.

Thanks.

-- 
Dmitry

