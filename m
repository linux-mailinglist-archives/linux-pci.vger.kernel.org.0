Return-Path: <linux-pci+bounces-11715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F4D953B00
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B97283A9C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D713C90F;
	Thu, 15 Aug 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D9ya+FeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EE78C73
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750869; cv=none; b=BsMUbWqO6nSRXHH+SHrpl6BxPI9XBZ3hiMwhGlDE0Z0GYgrVeRvy/jh8U72eDptdX0JjvVK5/cUArOll+r32yOvJO+javPZtHpegWbRZI8STtTdriZl360mpTB9R1iD9uEMdohpoUBJ7cKIyDI9gjwR7U+M7dY3bWMhutuqXVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750869; c=relaxed/simple;
	bh=SQVdiSZVhvqVY021468Cudm+F/E+dBACe2JM6+6lVvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aBiRLMgdFzphqMQAXLt0WQEKsjSxCE5Nain7PV0kkSzQ7iLVc/h9rVpl6/+WGJHDEIM7oclh2Lf1DbqkrDuQaNvBLbBfS8AlniP6H6JSpWtSsz8cWiGkpT2/HJidWa8+gJok4RRVkGE+ndRhxu0dkabUQa+fYAvFYq0H/57MXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D9ya+FeY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so1094208b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723750866; x=1724355666; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1VWISu56wcliniL1RPNMTZcS4mUkuTA+1qK0QABl0U=;
        b=D9ya+FeYa9wReAhPy+STJf3Dy5cRIYf6HBk8kKccYrSZvnnbEFntddg4KueD5vBRjX
         AdV5TU4jxWslqnVJlkSoX9fzfrw9lZQmUIm7h4LaU6BVwBy8t4YqaU06qsXIZEGIAYLB
         OmvtUwHAlLDUjTCAyX3mni4k+MNTg3tR0xcYVYPG/8Y/NqhK0neMpNEL3pDz9RZY9jV4
         Hh0IUXTkQVmtLISAH5Fkh8B7QJHESx1h8/+77HOwnrJL65bUp2wG4uSrAQ2YD3T3mcqZ
         IvZ3Dy2tXmiee958ufEWFwXL52566axMZol9X8bfb7VEEdIka1Zp6sNTAnNDOvpRFT6q
         2v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750866; x=1724355666;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1VWISu56wcliniL1RPNMTZcS4mUkuTA+1qK0QABl0U=;
        b=fb7soykqyK88MnG5EnZoLjlMgmmQ47tm7BUVMLNgeQf1B53NK5W5W6A44mtL7ok/Ss
         0s0hmxGgfDE9yVQEBQSgDLtsMxTzjvzW2hD3+emKsISRzi1h61iL0Aol0OO5oe3cp5n6
         uRdnrX+lobI2dSO9duWqOhOqMRG/GQFzvVC8ZmswPp0e5tHMvmbEFQt10RkOJqT/ZF0R
         /dtCGCEKCkLu3UuiVTqKgxU8cTyr1YpGz4brbNG5mvHBEJRo6Bdgzfzrp6b5ldrT0tEf
         lwgCFBiWusrlpt48LtaCQfI3nw5RCuB/neMCJG+Qn0ff2Q9wpd9bfJsIHvp8u2sXzCvy
         PASA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgsHa/5crnDDgP0Lq96DS7NZt3/+ZhEI3rAPnITuMz7qf5RLLwwdhhY0ZiVK0ZyG2KAUlhn7L9/Rj7PmwcfbSiaZc95z0EHuX
X-Gm-Message-State: AOJu0YxD/8JmIg5R88vC/fnc5CoQeg/GFvG8jMb/5kRiB6J/AHM9inXF
	4cTuHuhHM3Wfe1bZk2vCLZBakGH85DB7iGBubMv1sq579er2PNZEJhGOwJky0RE=
X-Google-Smtp-Source: AGHT+IGBeVra0eMWvYeLqHCk/DezHt9EnEpabZ2WKu9TSxo5+eSv9Ov+1Xc7qtkvdvQlB0z9sH91RA==
X-Received: by 2002:a05:6a00:66cb:b0:710:bdef:5e15 with SMTP id d2e1a72fcca58-713c4e71508mr894035b3a.18.1723750866152;
        Thu, 15 Aug 2024 12:41:06 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127aef410esm1342447b3a.113.2024.08.15.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:41:05 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Thu, 15 Aug 2024 13:40:59 -0600
Message-Id: <20240815194059.28798-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091356190.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Sorry for the delay in my responses here I had some things get in my way.

On Fri, 9 Aug 2024 09:13:52 Oliver O'Halloran <oohall@gmail.com> wrote:

> Ok? If we have to check for DPC being enabled in addition to checking
> the surprise bit in the slot capabilities then that's fine, we can do
> that. The question to be answered here is: how should this feature
> work on ports where it's normal for a device to be removed without any
> notice?

I'm not sure if its the correct thing to check however. I assumed that ports
using the pciehp driver would usually consider it "normal" for a device to
be removed actually, but maybe I have the idea of hp reversed.

On Fri, 9 Aug 2024 14:34:04 Maciej W. Rozycki <macro@orcam.me.uk> wrote:

> Well, in principle in a setup with reliable links the LBMS bit may never 
> be set, e.g. this system of mine has been in 24/7 operation since the last 
> reboot 410 days ago and for the devices that support Link Active reporting 
> it shows:
> ...
> so out of 11 devices 6 have the LBMS bit clear.  But then 5 have it set, 
> perhaps worryingly, so of course you're right, that it will get set in the 
> field, though it's not enough by itself for your problem to trigger.

The way I look at it is that its essentially a probability distribution with time,
but I try to avoid learning too much about the physical layer because I would find
myself debugging more hardware issues lol. I also don't think LBMS/LABS being set
by itself is very interesting without knowing the rate at which it is being set.
FWIW I have seen some devices in the past going into recovery state many times a
second & still never downtrain, but at the same time they were setting the
LBMS/LABS bits which maybe not quite spec compliant.

I would like to help test these changes, but I would like to avoid having to test
each mentioned change individually. Does anyone have any preferences in how I batch
the patches for testing? Would it be ok if I just pulled them all together on one go?

- Matt

