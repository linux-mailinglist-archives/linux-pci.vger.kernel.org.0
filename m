Return-Path: <linux-pci+bounces-2322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A90831D7D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 17:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB021F231A3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248128DDC;
	Thu, 18 Jan 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwpExfvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE6A50;
	Thu, 18 Jan 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594910; cv=none; b=sAPf4T/zsSWSz/uSjwyHAi9iiQr+o+wtTwr2cnOBzn35p2G9pKtvWtkUtBk1Axq72F/YePr9MwPnD+x+1WMcHdQZ2NV1CwSwbk0XpV1sT4NANnsPLdQZI66JfjFGg09UwiosZOCjdLnG5RXxgvA7yGFmY1dP5CG3AOxv1VdPFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594910; c=relaxed/simple;
	bh=KXuPJ6nv9tvzYJ1kLf0I+2+qf4u+fqZAEEjNUwGykBY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=B6gGizgDqPorI5g0kzZ1kvhS/n5Y+bv5hfvEqy+Hxo+o/I6rZ13ihDFFiG4JbLXT1cmlu6hhBB+C3BTGACPxLbdyeVnvlQh0KElhgpO46gM/xGIrlKXBG+H2Ecm6+o4IvN+9OW7vAo7QS2U0mkRHGAmRu6U8U52UQ6nkjvIfbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwpExfvX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d6fbaaec91so13014545ad.3;
        Thu, 18 Jan 2024 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705594908; x=1706199708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZyNv3BplxfFRt+b/CCcHm5bIKCnTAbW1I/ETCi+EZMs=;
        b=lwpExfvXUiTufXOnKqYBxzYC/ieEbQA/ktTV81+IcIvCttvKbCwR5HC8epFSisuZma
         tA1O7ngvW+jQHp6omv9nrbF3BA1zDxs+0tdPXJP+eS6qj5PeGLUbXf25l3knqrOoFyUv
         rH8HVYuQVzTxImIG+7XgC1PlEzEanXI52n3ZMGtVMqpSd6WA+h6v47tOUdOXQPIkB54h
         0X6LNRt09Gl5nFMIbpMlTQP50bJ+/tDLDfpoPyQLm0AkBTlC6lstkvxBHOWk5gzgMj+h
         /JYCKhmDqcrWTScnWwGAmFKodP1zCiGp6qC4OvJqruwwr60xuTgG6OVSktPxyGwBqTzW
         dWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594908; x=1706199708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyNv3BplxfFRt+b/CCcHm5bIKCnTAbW1I/ETCi+EZMs=;
        b=kWWorIbjvjiHgVNijZfdhWNEXdvcnXt2PodRAnIqBqg89xq7swTf8e0zbXPuvGT7MW
         kMFMmtMR8bcS/2dn56mL29/gUKzpQ0B4pmJazbzGw4nVwzBW5dsCzfTV5wC51Hsnfx8L
         hefXY1HHI/qwgmCEoS1Rsu0GQSgPYkqe961bpmqJOpyD1zvwPcufYfCpZ2Tcxei4RelD
         fQ/ZNS/QhBDhxz4I6xSh3hrRtRb/GBhLi7ev88O9a+236LcBBhEtCggxoDQue3ZPLedX
         hb0lWwwCZ6ms28RR6wjZKQNa6sb4x4P32W6chNQvzHnJHYIuouxqjBQ/eY4bH3uZrZlb
         3PQQ==
X-Gm-Message-State: AOJu0Yz32KylnAdUBxxEaPCwgeSbyvUjrP9dOLS9gb2M1Na32TawXwbu
	rTrtkWc8CUw9LPGi55NSKmHJ9gUei/PQiF5r4wejYk6o4jrGrDFHgFe/5vOi
X-Google-Smtp-Source: AGHT+IHfVnFNR8BDwFBEEiN82nMESNjALuPty+2DH/SEhud/IhDa7s7FlhHewq5SlgSMrVOzrg9wFw==
X-Received: by 2002:a17:902:c702:b0:1d5:dad7:c295 with SMTP id p2-20020a170902c70200b001d5dad7c295mr964606plp.130.1705594907941;
        Thu, 18 Jan 2024 08:21:47 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:77ac:1fe8:3f5:523d])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902ee9400b001d71a0b1109sm32031pld.116.2024.01.18.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:21:47 -0800 (PST)
Date: Thu, 18 Jan 2024 08:21:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZalQFx-VMcJt16is@google.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
 <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZalOCPrVA52wyFfv@google.com>

On Thu, Jan 18, 2024 at 08:12:56AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 18, 2024 at 09:47:07AM -0600, Mario Limonciello wrote:
> > On 1/18/2024 00:00, Mika Westerberg wrote:
> > > > Before my patch, you see that the JHL6540 controller is inaccurately
> > > > labeled “removable”:
> > > > $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
> > > > {removable} -e {device} -e {vendor} -e looking
> > > >    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
> > > >      ATTR{device}=="0x15d3"
> > > >      ATTR{removable}=="removable"
> > > >      ATTR{vendor}=="0x8086"
> > > 
> > > This is actually accurate. The Thunderbolt controller is itself
> > > hot-removable and that BTW happens to be hot-removed when fwupd applies
> > > firmware upgrades to the device.
> 
> This is quite interesting take. Does fwupd rip the controller out of the
> box to update it? By that account your touchpad is also removable as it
> may stop functioning when its firmware gets updated.
> 
> > 
> > Depending on the consumers of this removable attribute I wonder if we need
> > to a new ATTR of "external" instead of overloading "removable".
> 
> Isn't this the same thing? From
> Documentation/ABI/testing/sysfs-devices-removable:
> 
> What:		/sys/devices/.../removable
> Date:		May 2021
> Contact:	Rajat Jain <rajatxjain@gmail.com>
> Description:
> 		Information about whether a given device can be removed from the
> 		platform by the	user. This is determined by its subsystem in a
> 		bus / platform-specific way. This attribute is only present for
> 		devices that can support determining such information:
> 
> 		===========  ===================================================
> 		"removable"  device can be removed from the platform by the user
> 		"fixed"      device is fixed to the platform / cannot be removed
> 			     by the user.
> 
> Note this "by the user". Maybe we should add word "physically" here to
> qualify the meaning completely, but that is what it is. Not that it
> disappears from the bus or stops operating for some time because of
> firmware updates, but it can be physically detached from the
> platform/system.

FTR this is where Rajat and Bjorn have agreed what the attribute means
when it was moved from USB-specific to general device property:

https://lore.kernel.org/all/20210511230228.GA2429744@bjorn-Precision-5520/

Thanks.

-- 
Dmitry

