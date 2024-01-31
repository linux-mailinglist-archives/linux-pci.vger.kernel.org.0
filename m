Return-Path: <linux-pci+bounces-2882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CA843E4E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3EBB25CA1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8769DE1;
	Wed, 31 Jan 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="bvhgdwvQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533776043
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699331; cv=none; b=XFgHyNJWquKCHeAasDTxm+2AfMecFwaPXzXBwbFojVruJLqKGXe6G31zyy1GGjWBdEecIfZ22Gcj5IEhsySXlEwq+VW8MBrNjh6aASTqFpKZ6dKueYBB7UTaOdPKczgxcjMh9bLPt0kzVH1DetFwlOSffuOYugNclsU2giVYPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699331; c=relaxed/simple;
	bh=vFODrHMqiV3HY8+m5nSz6cb0kesdcNwMLRKYCpAKcWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pylMA/Z29RpWsOHXTW2zjF3tZUtZ7O5bxaFb1y16A+U3fjZUgHV27Lm7Hebp5KpFuXDWmtLzwKjjFjz8zdgIOF1adBKbS/IfHKCw3N8FF5BXUdm07D6nymhn4zyHSHUKeUIk4JeaLDTC1WibfgTvQgNLBOX5iykpMqvoZGhC8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=bvhgdwvQ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso1483642276.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706699328; x=1707304128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDAR7PJX+EQMyirL/3W1Y6Qsu12zaieB0DRPT6UdUiA=;
        b=bvhgdwvQy871L3F5qJLo6O1lJ0Mepz0zG4mXTBg7yPn+y5BS3gE2saBNMqXryHnKl7
         hf3DybZ8d1a29s8P1LGZbXyc64BwODFEykbUmX++byV050cgeVopMNDO3/LkD5KiJfQ6
         I5IZb6RILHJXQYEAubvvBfA82npKFEKoAWbIQr+LIIBksPWzPDC227XTgAPXise1pXAC
         ZMmiFMFlAVn104+h2pfVdPLFvc630m0zuciEh40fSp0gSTMKo06mwgnDGFcXERyQdtqr
         tuU8gKQ8k9XiJTb/kaR2SKfffRlVfHYlsnoevSBCYDSJFO2pl2PCFDie12KonNByygsv
         xkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699328; x=1707304128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDAR7PJX+EQMyirL/3W1Y6Qsu12zaieB0DRPT6UdUiA=;
        b=mLCOU9KAux8Wn40A+/JZ192v9zQ1sv6w8CI1pgmMizPjT7bBcjcA1FM5mobgGfk+w2
         n4Czjz2zuSRUA1LiYTxTIbSIiSzHhYDsBlB87Qmsv9n9eOdY3ORK5jJ5ZsmEsbFeNkTZ
         VXMnSlBF5hmXtxrbZB7sk+obuXZ/xwRcTpwptzq1hJyy1xTI9lEiQYaGN5Qe+kGNmPir
         Iqorgm3izCTTyhmXPb/8kTz3gIy6ttQkz1co3AGfV8ClJ8QECv5QDa4nXyzwajjiOSwD
         XA3+eJEb+IdsyD6FRJSMjI0Le/WDtKLdoovbyoL6Cdzd2BXYi+L+BPUM4fdqtRvXv2Aa
         zrOw==
X-Forwarded-Encrypted: i=0; AJvYcCXp1130vLLC6lMy5YetnT9WYrJXuNfpoZc5JL1kIdfr9G3w+Nh4NavX2FxYSjFnv1ps5xELyXfLog1qdbdTeyzw8QwT4+fNLV55
X-Gm-Message-State: AOJu0YwtiE3Uy7K/DAgXMolr1pzXuFHxfEph2bI43Wy2g3fvUkzmi+Tv
	22rHc3wUaalluq6obGg9ESeifaHxqzcSj6oHVLrY57NdmatSWwrgenYlzzXIogFB6PydkljRGXG
	ZtL1Kz4nyijkXKyxzVbwe58YgH7TW5lkZIghIaQ==
X-Google-Smtp-Source: AGHT+IGmAJYZ5cT3bVX5ItNSUhqyQs9ricprzI2Qyl4PaknWlx7aDB3XuBabzFiY5c8lSvvNorSCWQig/oBi/Q5U3pE=
X-Received: by 2002:a25:e08a:0:b0:dc6:9dbf:8247 with SMTP id
 x132-20020a25e08a000000b00dc69dbf8247mr950340ybg.3.1706699328384; Wed, 31 Jan
 2024 03:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com> <Zbonprq/1SircQon@x1-carbon>
In-Reply-To: <Zbonprq/1SircQon@x1-carbon>
From: Daniel Drake <drake@endlessos.org>
Date: Wed, 31 Jan 2024 07:08:12 -0400
Message-ID: <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	David Box <david.e.box@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:57=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
> Unfortunately, we don't have any of these laptops that has a Tiger Lake
> AHCI controller (with a disappearing drive), so until someone who does
> debugs this, I think we are stuck at status quo.

I've asked for volunteers to help test things on those original bug
reports (and may have one already) and would appreciate any suggested
debugging approaches from those more experienced with SATA/AHCI. What
would be your first few suggested debugging steps?

Non-LPM boot:
ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

LPM failed boot:
ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
ata1: SATA link down (SStatus 4 SControl 300)
ata2: SATA link down (SStatus 4 SControl 300)

note SStatus=3D4 on both ports  (means "PHY in offline mode"?)

Daniel

