Return-Path: <linux-pci+bounces-26707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CFA9B47B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B629C7AFEFA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D834CF9;
	Thu, 24 Apr 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP3UgfZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664028B4E5
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513397; cv=none; b=fVlmwjY+LxWfqo7Fg9cX+VNkHCluakpduI+4xn8yvTyjTix86aIo0HCCzH/aru+7YtJTvQ0cisOsyhZkPUR5rXpKTZR+BfKyN2a0gKVUfc4Ue1O7XuAbxTdAyYhQuLyCb3lRFAUXNfvyICEwxjRR9NlilKC2DfARbJhukcSCtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513397; c=relaxed/simple;
	bh=rXUC9iW6sscBGdwu9qxZ8xI/1mYoGfT1AeVSKyGatsk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CZmHhzWOkV8zp1OxnHoEBKfFYIeRDu3vVMMG42GMUcFr+VWHNHCGDg9DcSIE8VtMBoE9GnE06KoA87d4ydCwlA9zbA9qDuidSeYnBAh0mTE0Qjtba1FecoGjWZPRV2EdeJwKoupLoumQV96zQZt529kiD8/Q4VcNEfBpx/ciRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP3UgfZZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fda22908d9so10933687b3.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745513395; x=1746118195; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rXUC9iW6sscBGdwu9qxZ8xI/1mYoGfT1AeVSKyGatsk=;
        b=aP3UgfZZhapVPhlzZYVdqQh0cTAycP2kCla06hxJ4LFNCX1lIhX3nT+zxEEfPk3sSJ
         8Kqh/E76XZ4Id33oGy5EL4AsY+J7v43lrbTCyLn12jmZXe8gKe3rXmqO38Fh8vGtceLA
         RAqqPF3IrWdvXLQEMEr4faY8FC2s/rjVKyLYOsSpIFRqVO2CUAGrUA93nLr1diBXmRXh
         NEeEhqPRpNdTNdPIjGM0M4SSauPIZzt2Lg+MNcf//PYjx+ckJept+b5Z/5yeldE3CW22
         AiefBHji5mPzR4Hr5sTsXrM/3iLqOCYnVeJGyr8/ZLDsGHHs/ffjP47US4QOgqRtQQMJ
         uDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513395; x=1746118195;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXUC9iW6sscBGdwu9qxZ8xI/1mYoGfT1AeVSKyGatsk=;
        b=VgIpvfc9aTo5cx9fR1bVi4dXmpYyicxZlKrnKq6vY5IlQBqzZrMCa30Lzyt+VLZOE9
         4gd9GvT/ZUZR/RVg95ZT7jnp4J08eeCfEg8QaW/tzJBi/DyqAdYWIW4j1UGtGOR948wD
         hQ3Lr0GIoxhXK/WKOcKPWU8vV2qKGcnClVPk7gWj7d4AnGYeMbTrM9558YU6BhoIhU4O
         B5hT5NqO4POwauZhOz+OfUeb8Au3TsNjJRlubDuJnJILwOdeljQN1DmjuWVSY6eoKytE
         WpGpj/E7/iavNeto1LYmp4DcQ7UcGWKmbOXLc1aptO1+1pvRAsZs1QaLG+qvwNuhmaVx
         SYjA==
X-Gm-Message-State: AOJu0YzmjSpD0uWJtPE8htZsvSYfCM0ID7bp2b6qGC854CDmqVuKUD5E
	5b7IhtVdTnvJtZGPiTEfdCSj8GYwTqMcb4GY/UxN9zdjtWjiTHcd955Ea7A2+MhStVgPawehbNn
	5HY8cZJOJzTH7FHPiEXCD4ayJBmimetA9
X-Gm-Gg: ASbGncts1wR2EtgKolaiualAtBEjnUbEJYKQOhlVCFL7L1iAuMBV0BRyYX6Lhl8rnha
	pkHv99Pbkpp1W01Sr71onVgPCzkRo0QFlZ8Yh1JVO48k6dlbfBQibqqMm2kJ1hrEPkDcoR6iDva
	HWlzklN5mThrMF+zStkaSkNw==
X-Google-Smtp-Source: AGHT+IHPttLNVU+nQEs7rF8xsSK1jNjZ50TIQPEC2WkFKzroUAndkiONieVU0VqtlpNFgItd3OeXCxlR0fLkemZSXLM=
X-Received: by 2002:a05:690c:6104:b0:700:b007:dbda with SMTP id
 00721157ae682-7084efe08d6mr6930257b3.9.1745513394977; Thu, 24 Apr 2025
 09:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Thu, 24 Apr 2025 22:19:44 +0530
X-Gm-Features: ATxdqUE_IfxG8TSS5i9Lb98ZXmFW6VNoBcHJRKVWC6onQIZQhCum4VNP-6TCVWE
Message-ID: <CALfBBTsD40J3PAv4LXit6oTmJmeZOVjN+FG-PN2Aj2+KyPFahA@mail.gmail.com>
Subject: Problem with kernel rescan and realloc BAR resource for endponts
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

The command line parameter

pciehp.pciehp_force=1 pciehp.pciehp_debug=1 pcie_ports=native
pci=nocrs pci=hpmemsize=256M,realloc pci=noacpi pci=realloc=on
pci=nobios


There are a couple of endpoints connected to downstream ports on a
switch, and the endpoints are not visible during the BIOS (seabios)
enumeration, but they are brought out of reset just before kernel
starts pci scan.

Even though the kernel enumerates the endpoint with proper bdf and is
able to read the config space but its not able to properly program the
BAR register, the lspci lists as


Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
[size=32M]


This is an emulation platform.


Any inputs is appreciated


Raghu

