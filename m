Return-Path: <linux-pci+bounces-32992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451E8B1332C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 04:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511B173D07
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66FE1F4606;
	Mon, 28 Jul 2025 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiQbiB7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0D60DCF;
	Mon, 28 Jul 2025 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671235; cv=none; b=JJdHWtRflXeeT3WNCfDYbc5vHeIA24HwCMwhs0D6ycVLO3anU82emDTfxLrNtXI/70VH4gPMd/H/RJcqpPpk3OSQdueNdMnUBquU9TLEJDGAW/Sc+zuBMmwmSU2X1cqBRFCCuOExjEqUxjqVro8U9LG1Es8csF1h/hq4gTflAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671235; c=relaxed/simple;
	bh=AO8ExueeFDrWkBuqgwFTApyFkJq4/UGY2C5kxNOOkIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLFtkLwULy+xMM51pk/ZGsaSOe/5N0KT4jpdaSO++9yAZN5U+WhbQLO1pqpwNChU65vU2iz9BagnscJGXSyD9hk29yVJvuhRBhnrp25pOXpRrhlFudXSBf5+jVlZ9g/GzPrcrDSyY9pXEG+USA9SVammDPKU4ARJIKu+JC9ZIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiQbiB7M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3576606b3a.1;
        Sun, 27 Jul 2025 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753671232; x=1754276032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avmHlpsimPpbcMG0DyymdLKOLlQNmhtiWj3hCWq4+7A=;
        b=KiQbiB7MubzBobEXPdz5SBpmP//LWP20s7PBbPjTqsJtdV8+sKd80wEB3UnIkC2dOQ
         q/lSaVHflqJ2P8LdQHacRP6IPBJLnam/Ubh0nvbVYv8UFCY5Qzq+cESJSITw3jUGKHUW
         VXclJSXxh/fsXE5x2A040uQcq7y+kR5w/TeBHC9T8YFyzTf+HUnj+DADmoIDlStoUo6D
         wdJ18EOR7pFL3C1wzH31d5+KrDgK9j/JtVujZNWJGCbZuxFNdf5KW1K7peYDMqDme1bt
         jSX9d5HvaaigjqCqH/WY/22zVYJ6XxWJyYpP9Q8XqFJX2lr7JSm+8gL38me5+NW2hE47
         rsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753671232; x=1754276032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avmHlpsimPpbcMG0DyymdLKOLlQNmhtiWj3hCWq4+7A=;
        b=q1f/Gtsbr/I8YuiJIjvemm+slnY9x7Ffi9/77MEKMIdE8Y/HXMl/ackidjyUCLOkdU
         51iSiRufNNaWfgHSEAlaY85PvPsHOoIXbrTtfW2feAuQKdXsALvdXrJHpWDbI89SPd1m
         USMUBUxd8Hqye8ljsvO2uzRWun1XUksrI+58Y2fug6ex4he1nxuguIhVNyS3HMKUY3W5
         SLXAQZFgRkoKFqhrJ3kWvVUQQKFGkkmEK8t9klj3B4T3knBPZ3jF+6pKk6qjguRYhGUy
         cfpHMz3y6v9ac4bVtOvNu0jqDW2WSaZ9c4vf+iUxyV+z86s9mMlJZgqe0kqw3f533uMh
         BCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOeZQCmOxYP1ixKWCDaArtSa2r9dpQ3YVSnUAi4H5dbDjErG/AXlCY2Y541YnxXiLiqg+ZWixNfh3E@vger.kernel.org, AJvYcCUvJCKgU1hbqXqQLhH7jHNT79PUpXllJFHrfk6ItJhrcXPHvcJUbdpZzr8DYCebaQ0uJXC6cO5WUyemp5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7PzMamRuYlCReTK4TWxl+Bu1mUvFGHp8kLxNOz26eQvvueOXO
	OD2Uaoys+nuvVbOD7lVq4sZ6L4VqLQXghmI0v/Sin7nH9N4lvwjRS1u0
X-Gm-Gg: ASbGncujgsUly6GtPzDT+IosNjkjv1xHSbQgI1qSqxo12vPxcDA8OU0J9mfkjnknG0E
	zdxFlW56gZsCEC4e7XTfhgaTzdXDy4HbDsIYb1kDpYKhpwcMBu0gbwbSP7B+ZnTZTtD3AVkomEx
	HjKG/kSuidPUKA3E4Sb6Evw20grVgixtJO/nAP5bp/ZXWjjFKsV9D8FIwSej2D+EGed0pFQmS1o
	1ZfDWHeRoKqcnb9ekNh3Sah2lDo4BgCr8DrgQkSpndfWR4hM/5Ew9VyBCIP+Ax2kxCWUUqZw0K/
	3ifkeOSf7RC0TPxtOmcy0t79wcb7Qjsj+WD6e+HffVMsPORtXPw1Gtq+eZyEJ0ryUjaS2bpJGAW
	OdNgeyUSkedYEImIS4l1rNlstYBI9vMS1tyrBLf4OSDj3gyfQ1g0Bug==
X-Google-Smtp-Source: AGHT+IEYsDkEjeROakf6QvDIh82nureJAidRuBH/5kgU/0KECEZzQNwNS08YU/h476V5OM7NqtrndA==
X-Received: by 2002:a05:6a20:3c90:b0:23d:34f2:3a22 with SMTP id adf61e73a8af0-23d6dfc0172mr15767894637.7.1753671232393;
        Sun, 27 Jul 2025 19:53:52 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4d15cfsm4297219b3a.119.2025.07.27.19.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 19:53:51 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: raju.rangoju@amd.com,
	helgaas@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	bhelgaas@google.com,
	Sanath.S@amd.com,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH 23] PCI Add PCI vendor ID for ASMedia USB4 devices
Date: Mon, 28 Jul 2025 10:53:45 +0800
Message-Id: <20250728025345.5318-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---


On 7/23/2025 18:16 PM, Rangoju, Raju wrote:
>On 7/23/2025 12:44 AM, Bjorn Helgaas wrote:
>> On Tue, Jul 22, 2025 at 11:20:25PM +0530, Raju Rangoju wrote:
>>> Add a new PCI vendor ID (PCI_VENDOR_ID_ASMEDIA_USB4) for ASMedia
>>> USB4 devices. This change enables proper identification and support
>>> for ASMedia USB4 hardware in the kernel.
>>>
>>> Co-developed-by: Sanath S <Sanath.S@amd.com>
>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>> ---
>>>   include/linux/pci_ids.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index e2d71b6fdd84..3397954ce96e 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -2592,6 +2592,7 @@
>>>   #define PCI_SUBDEVICE_ID_QEMU            0x1100
>>>   
>>>   #define PCI_VENDOR_ID_ASMEDIA		0x1b21
>>> +#define PCI_VENDOR_ID_ASMEDIA_USB4	0x174C
>>>   
>>>   #define PCI_VENDOR_ID_REDHAT		0x1b36
>> 
>> Sort by Vendor ID value (not the name), per the comment at the top.
>> 
>> Use lower-case hex to match style (not universally observed, but
>> close).

>Sure Bjorn, I'll address these changes in v2.

>> 
>> Per https://smex-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fpcisig.com%2fmembership%2fmember%2dcompanies&umid=7321be44-7922-453f-bbc2-19fe22b27570&auth=777e34cb6e3f3df7218bc96aae4e57e309393472-c37a74b95e80c9c8801718f6d732e8ec1f1f31bb, 0x174c is not
>> reserved, although the same is true for 0x1b21 and many other Vendor
>> IDs.  Do you know the history of 0x174c and 0x1b21, or why these don't
>> show up as reserved?

>Chloe_Chen@asmedia.com.tw, could you please comment here?

Hi Rangoju,
  0x174c is ASMedia USB-IF's VendorID
  0x1b21 is ASMedia PCI device's VendorID 
        
  You can search it at the following URL: 
  https://devicehunt.com/
  
       
  kind regards,
  Chloe    
>> 
>> With these,
>> 
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> 
>> Bjorn


