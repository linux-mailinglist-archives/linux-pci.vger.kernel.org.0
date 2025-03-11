Return-Path: <linux-pci+bounces-23435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93696A5C433
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD67116E9DE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86D25D53A;
	Tue, 11 Mar 2025 14:50:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCD25D216;
	Tue, 11 Mar 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704633; cv=none; b=eWK9uzmUOxyzI8HtyD4ZSJGNuIGQKB+1rF0hlN+pqzlyi4nXSuGXaM+i6pXgkB/LCRR/B4Z6eWoS5CTO+sc1W7YCemegI0VlmN+RHsePPqeGC7SmncP4EngPBObkaw7U262qvX8Z/Uvoy+1lEByRkRIWrwglnuvgbqCtTTjRmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704633; c=relaxed/simple;
	bh=4lmcq5ZZwzactbRQcXCqPLCD7mDv+XMdrNz20S3pWfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1r62buu2tRKei7c/DPXPy9N0TcN/i7MpIrSGU7Pqa9bDSLeigsQp287FkJbnE+/w2iuqsGiYB4wQ13Obmht6gPO/wpInXj/qNE/tRFpJG+5ZaDEXDRN63eBnX/fWdM6/mNP8Spc9DEBfaXbs3sN9gUaanNkNNzFEeResHw7rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so54374415ad.0;
        Tue, 11 Mar 2025 07:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704631; x=1742309431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVyuEZ5ayTQXaHdA6G0xQuyLAF5Q6jONwkliJkNHzfI=;
        b=mgN5LQQEkKdi8aCThn0JBuwayXu5nyDNFBWaCATtcPkiKbAyZU69GwadAHAFu64ceO
         qB131ZSmT0G5Mdr45qFs64VKpev3mB8BIxVx64l7JUqvP4Efu0kxbxrrQc1oLvmdOeIb
         xGsknT81C7QMkrLuD3XoyX4qqTbS3r0D+IOBPhhxGuHQLtD/CdD160Eb1wJlfW9qZXqc
         FRmtOuRNogPDwmSZuyfXnNG2S6OkYWLds7u+IEPz6bQF3IYuE3gcC0jZPib5DMST+gXb
         joR0ThVYCYtSUAGcrFreg1jFeVMFGhUZY5/qblFuy3MeogJbJd4E7DykORIdhKjQNKT6
         nOxw==
X-Forwarded-Encrypted: i=1; AJvYcCUVjsO+WWxHUqSgsGeXsESOY3mXy7m1gaUx6bl9Nb/vGihDtN668gGIj4g8dOrX6syKDqk908wVWIAE@vger.kernel.org, AJvYcCUYsUhm3sSHuvLz0p0zyiPCDULEF7E6Hf+nA+RcT6jpdHuez2WiX7/kdkDt9ohU9/t1M6Sd3xPrJk1HiYmJ@vger.kernel.org, AJvYcCVJyn0LW3eFvpQ00oHSg+BAGaTE8j4iH7luq8u45bHyNTNQjR9dM7GMAlMxyRJ79mgP4cblYUIyFrq0@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMwX2iWzTJ2z2p1J4bUZmC9SHANObnVVboVGCKkFpDmj2hSWZ
	tZddMe/9cTZyQePrTTWW7YOSCh4QyGip7FdNXc6jChIIzUTvSZD2
X-Gm-Gg: ASbGncs10d0TTaMBAkoRuxAFmAbsJK9fXCtc7wpKqnbqumx9rsymLmSemiVBynz+w18
	sfBLBSeUq8Hy7JWvagCj3rGrX0/Lz74N6MT3mTpZZXdHl5BTOevQsiQ2mgMq++ogYnECbJtnmFX
	8YTtz1dU4S1RHUOfC2e/rJfktnTAp3mpwEBJAu0tkaj5+xekrhkzGgSyYrxfxqYw6d9/wzj3X8P
	sMpv1pV6DwZwh/QSv8My/eCtSVK1GlXuTiN3KhaG+ZwSuMRiM14QZJtp0xa6pTHC0P4y4SiC/6z
	VI4C5Qwuzr3nv/UwWE50Fz378ZwQocOWKz83/9N7Sjx74aq8Bt4Yy8SXpTV668yA/wq53HqWSST
	yr9XwVjnw14BmPw==
X-Google-Smtp-Source: AGHT+IGdJgeKVhKajnMxgSh2wylNG86vUABnb4vWhG/ixoNGRx0cQ4LL3IBgYYmKri5ZSubchOhaKg==
X-Received: by 2002:a17:903:41c2:b0:223:6657:5004 with SMTP id d9443c01a7336-22592e454aamr69659485ad.28.1741704631148;
        Tue, 11 Mar 2025 07:50:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddfddsm98784245ad.2.2025.03.11.07.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:50:30 -0700 (PDT)
Date: Tue, 11 Mar 2025 23:50:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in init_port
Message-ID: <20250311145029.GA1381004@rocinante>
References: <20250311072402.1049990-1-thippeswamy.havalige@amd.com>
 <20250311072736.GB277060@rocinante>
 <SN7PR12MB720164A0B40D1EB3DE4822AF8BD12@SN7PR12MB7201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB720164A0B40D1EB3DE4822AF8BD12@SN7PR12MB7201.namprd12.prod.outlook.com>

[...]
> Thank you.

Done.  Have a look at:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/xilinx-cpm&id=ad3b7174d4d04b7e2ab81df5857c4da6b4bc1ade

Let me know if there is anything else that needs an update.

Also, if you have a moment, then check if the other special cases for
CPM5NC_HOST variant are correct.  Would be nice to catch any issues
before the changes land in the upstream.

Thank you!

	Krzysztof

