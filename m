Return-Path: <linux-pci+bounces-31938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2532B0211F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D1AA405A6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82152EE98A;
	Fri, 11 Jul 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVegu4Ew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44127A91D;
	Fri, 11 Jul 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249893; cv=none; b=S2J/ooNA79t/CDT+Pu1T54YAMkB2kw0a8+e9S+vqtt68bnTb89+sNTHATIjUnQB3CUWlgn02YiDUkyA0DWpcwg6ORd28kcfmJv7ZszlurGC6CehuFo/LgV60yuzIBK4UHsbrLg95XFkvvnFC+n7513SkOzuNoDrpat4WWNqBc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249893; c=relaxed/simple;
	bh=/BGqM330Q0S9LfM4RTN9305y8KJx7EcufJSqEP9f9Nw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tCk0Dq2gbsShWwBdTtwhxXVG8dKIMfHrCZogMP1H92uoJhehQ4Aq01Gxmfs+ZECl3GGdXl+24XOKVOddw0M6WqiWT8kKeDxqqcEbxi/7xkXM9byV8utrcWIGrfevpUk/ITkB6sFUfKm41xwb/MnRontCnjNsgjx3JFXRKR+dqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVegu4Ew; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-236377f00a1so22247075ad.3;
        Fri, 11 Jul 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752249891; x=1752854691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/BGqM330Q0S9LfM4RTN9305y8KJx7EcufJSqEP9f9Nw=;
        b=TVegu4EwFbkVOUxWJpQVW6HFSAPVc0RFZOtZNMXm4FrcjT2FUGoJOp8g2iZajGckgR
         NYDnuDElmvbbpaNy1SrdVCMm+6lWlBwaAhd/hWeCovB8u3Ilt0rQd6YQkEDC6nGyGDAV
         CrGNyrWm0w91mAGs9CwEgmbtpUb/kb1WoYvQpvMjtSfKcyxZeGe1+XEymX0ZNA6gnoUb
         XEAtCp8fiw3yH9CDdVfKO+vOZuQamAMTNX2NRRR58wzYzrAQptMXDYW3F7bd2K9zh+2N
         C3l5lpZzIikQ3/rMMTQ6rTa6qNl+WxcTm4VWk+uDuuVY0QEjOeLeNiPxO1UMM2iNqPY+
         YBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249891; x=1752854691;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BGqM330Q0S9LfM4RTN9305y8KJx7EcufJSqEP9f9Nw=;
        b=GqZQ2wD2JkaEHTaJ1OymIZI8VBpnqTu7m6/005rxuonXAEiv2z9M2m3/1WEm4bId8V
         C5xAPUQZQ5/0RDP7IooOs58utmZUjI3oMNX1x3+dBbTNFC66CJ9IgiIQQFvAc1iUfv2J
         mN2kEK0Mq2nCl2a373WE2PBxE4CdEfFVXTOZHrTPByEDKzqzhGtW9MkjcOCJ3Buu2yJu
         z/Lu1iO5kipfvcAKRzOwIEDXJp8ByfUzt4gxrQC36j2vcqOkLTPTlG7GSOrXeRwSI6Nr
         N22+jykoqdLAWhkC5XMyL8TE0QKcelobAp5aepMT714MaNXBNf4jo3jH/7tFKI7IXyn/
         eyng==
X-Forwarded-Encrypted: i=1; AJvYcCUJuGAuuzflBIeiZp9rBHq5riZihJpGWRAajw7LXSiGj5TdWgIt2KlK6L/rKAxFTq4KaqHIHfgCXXFPsnnwajc=@vger.kernel.org, AJvYcCUjkohC9NP8jLDjdtELIVxTMSqR3Y9g7aA9YFCHSkz+BMs5LzNpjsOhwEeyTuZ3VubZ7eW3/OzmYGEf@vger.kernel.org, AJvYcCWi+tOJWHH+0xrVP+4hv81JpeZfmE3Yv4N4xcr8IH98z1FK9ICL0vcC8qDbnakJnr3F6Mux+BLp2Oxw@vger.kernel.org, AJvYcCX5Mbv+UzptkpXnmkCpbRbZbAXKCH5WdkTxCGI9TAD98vrLxERWaiuK8/yOh8Z4JYOCoPKYvBaQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxadmJoPFGG4SlgL3liwsM3xTQu97pChJSBMMwH6gwvSWOip7z
	2OwLaMTrKG8uJtbr5mJCkCWc8iiARI1JbWthPScogVm25t6bnhGnWBeWSyFS+jxRhSg=
X-Gm-Gg: ASbGncv2FoLU+XY3En7cYrSIlM0GHxD4daepEDlFGtvOEtPmNP9qf5QacMb/fz0ANoe
	epuK6emw8Sq8zthiQN0ZAWQ9jUAFgzorPdoruyBvKwsPrluvwBeydz3lSZIzxp24JJ3he5knaoO
	t0GSyXK/FXNsOm+gpJ/iU366TAzO0YYZdaFgL7AAIGQYVx+aTzNKK1GSd4VTwL3+drkc12i2m8X
	MbyWDuNiQKsVv2eHod/QX1vTVTPozpo47hFLw3yYhYMu0dML5B+YG5mVZT4heIcy9xLMihpKRWa
	UiWXGeCR6F3CFfnMY56g3RsygYgKk9lPYNOLZPDap9d7fMqJovJkfUlp2NCSCKnke4hmGFR8zz9
	hoI9BBytyp2ZwWC3gya1VgvudYXYekcMDsNlH/20=
X-Google-Smtp-Source: AGHT+IEJ3oNx5cIlUjLOmHFUNTHkmdkqAsMISfC7Mxkw9B+ThDVLGY3uFMXn7GPvV+fHnVNaD+WHOg==
X-Received: by 2002:a17:902:db0e:b0:234:9656:7db9 with SMTP id d9443c01a7336-23dede7d62emr65105805ad.32.1752249891094;
        Fri, 11 Jul 2025 09:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4346187sm55118985ad.193.2025.07.11.09.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:04:50 -0700 (PDT)
Date: Fri, 11 Jul 2025 21:34:43 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250711121537.GA2289649@bhelgaas>
References: <20250711121537.GA2289649@bhelgaas>
Message-ID: <FB546B0D-2209-4FA0-9DC9-A75C0BC9FA4F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I really couldn't find on the internet how to compile a single file now th=
at I have compiled the whole kernel=2E

Any ways to do that?

