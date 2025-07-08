Return-Path: <linux-pci+bounces-31728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA8AFDB4B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 00:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CC4171B04
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93132222594;
	Tue,  8 Jul 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MYomEbTA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BB203710
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014968; cv=none; b=GZRfxfpuH8Sw71AdJ3YeMxuoZBlVWwAGcDQgmpEYEm7rfXO/ysGlwjaRp3Z7NnTYutUWMj4VAl5wYdurXsHihAgjZCxOoESTWAZGYQPLnhPShyc4SFQ9eKLtXJE8hTbowruMkrNL+bymGepqQ3fLFSdp0qgwRYYMotkMsSD51Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014968; c=relaxed/simple;
	bh=1vLlUkcZupTCHv8xbW6oBYHy1pPQT9nPxiQ5gcngf6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2aEdqc2LJo9E5xgP8DWy/Tgst7YXfXPkgvjOt5k5FJ1jWyIJaSbVDkDHH9b2VNSms9rNuoUXfGFkaCT6dlfwpXzNtQRoNfJpxb/gaNrmPxbupQcWLU3Od5nuND15EUdyf0BVnvvbTCWPPTCSj+LEYHKshGkB743IOQXencG6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MYomEbTA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74ce477af25so2991363b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752014966; x=1752619766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4tr4T6NYv1QSYP58u879vVskZ55NGSJOyNu4EM8Uo0=;
        b=MYomEbTAsV4aiaM66xDz1D4GWazYKX3987NacbdjGLDxjuGcYWKKGhIPqkqDUFBz7Z
         wCENGUiKElzigOQFN7/aEoJ88cIvO1r+C2ceOeXXgekKyDUDGWx6OL5gK8eFlP4hq/+K
         L0/xYzw44uLtTZQRrdtQOtMv4TFFA6PYT7lF1zSfrca1c/UPAXswMn+LnCiHMx5aGwUL
         hHVTxe9Xm2RN/xgaaz0u6hOvaiCz5F2TNFa7lgB2TcjK0afrnhMF+8LbLUVsiSF1BIkk
         yuDhGhHwBcoC4ggoeJN2zJTeYYmb95bWXDj0fZTZSB/wmuFX7V+EVmOVyXsVybo/UQ9H
         rwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014966; x=1752619766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4tr4T6NYv1QSYP58u879vVskZ55NGSJOyNu4EM8Uo0=;
        b=HcQubUDSophFouIrgd+pHQ3mKjxQgxgnRSlaWCHD5wz/Ze2COBAg8TahgqJC7dLHGg
         lXAVwN6Wr4nI/qnt74KSTWKDLX33nDDtoUwOtfe5renyf2Lng9XCF2AIc6vdvNL51Bv9
         AjMnYF/8JOML3OyN+XL6Dp1sDjnI3t5hfOLCTq37+JIB0e120gbaLi2ahjnd1nf8Emux
         +MfiIohhLAx9CHbFjtYP0V/jUI0KtWJ/bdtwiRL+7gytqUnqa8QUwSxrNYZzYgEK5NkL
         +pe4pHxoRXjN4p35JOIdS/41Joyy8HCmk8LpMv0U/a2LvQWz8FiSAbJPWchlRZPdXvSs
         J87w==
X-Forwarded-Encrypted: i=1; AJvYcCXa4aV+qpF0bpKiAuToUAlLf7mJQ+ZMaEyNUYjFta9zku3RzClui56zlGZK+nVJOrAVUgOZixRWCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxV8AIRMud3C/0uiVHi1eL56VkPYDTarpUhD2SiKRP9TIJ1nW0
	85gHad69MVxLccfsiIy5+uwqoj6hfWq+NFIgyfxQfjt2GaTK42CbER1dgznOr7BOMOw=
X-Gm-Gg: ASbGncvsXwwZ7P1pROunihwzz8zqN5faZv+OGKoJsU6fRUXNIZcN2+oE4pOQXezjdPQ
	R8/x3T1FdafEuEJgw3hSlkdy+C3aVgJOgK/58nwLfhvd+e0vgGQcTkbbqlNJhREC8WksiYZifhr
	B4qiLS7QjNb3wpv9qaEefV51DlNZNbGCyUDfg3E3JP+t94brYx7qvmmVsBKUySdVYE6jt2vS92d
	MlVlIqxwjvLkQtgBw2CBuE5LqUm1W00Yw+TSTQs/xnj+CSVEs86fMMOsnh5vq9tJtrSOFd9liv4
	7BBB0VIaHLMLQnnta+y9JuByTy7FgKWjekjtDCfreMh4lljjdKO0Xw/7DVg1vzfpNuYNG4o68eZ
	xqqNtMzBna7cw
X-Google-Smtp-Source: AGHT+IH5WD8XFrdbdkLuRPvVQGEdw4k1YXlsR+H+OuhKV9bUq8nn2N+Vq8Gu5teO8YcKzORiYqiusA==
X-Received: by 2002:a05:6a00:3924:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-74ea66a0ademr514794b3a.23.1752014965875;
        Tue, 08 Jul 2025 15:49:25 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce42cec44sm13177481b3a.155.2025.07.08.15.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:49:25 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: ilpo.jarvinen@linux.intel.com
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Tue,  8 Jul 2025 16:49:15 -0600
Message-ID: <20250708224917.7386-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <62c702a7-ce9b-21b8-c30e-a556771b987f@linux.intel.com>
References: <62c702a7-ce9b-21b8-c30e-a556771b987f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 4 Jul 2025, Ilpo Järvinen wrote:
> The other question still stands though, why is LBMS is not reset? Perhaps 
> DPC should clear LBMS in some places (that is, call pcie_reset_lbms()). 
> Have you consider that?

Initially we started to observe this when physically removing and
reinserting devices in a kernel version with the quirk, but without the bandwidth
controller driver. I think there is a problem with any place where the link
would be expected to go down (dpc, hpc, etc) & then carrying forward LBMS
into the next time the link comes up. Should it not matter how long ago LBMS
was asserted before we invoke a TLS modification? It also looks like card
presence is enough for the kernel to believe the link should train & enter
the quirk function without ever having seen LNKSTA_DLLLA or LNKSTA_LT. I
wonder if it shouldn't have to see some kind of actual link activity as a
prereq to entering the quirk.

> (It sound to me you're having this occur in multiple scenarios and I've 
> some trouble on figuring those out from your long descriptions what those 
> exactly are so it's bit challenging for me to suggest where it should be 
> done but I the surprise down certainly seems like case where LBMS 
> information must have become stale so it should be reset which would 
> prevent quirk from setting 2.5GT/s)

Something I found recently that was interesting - when I power off
a slot (triggering DPC via SDES) the LBMS becomes set on Intel Root Ports,
but in another server with a PCIe switch LBMS does not become set on the
switch DSP if I perform the same action. I don't have any explanation for
this difference other than "vendor specific" behavior.

One thing that honestly doesn't make any sense to me is the ID list in the
quirk. If the link comes up after forcing to Gen1 then it would only restore
TLS if the device is the ASMedia switch, but also ignoring what device is
detected downstream. If we allow ASMedia to restore the speed for any downstream
device when we only saw the initial issue with the Pericom switch then why
do we exclude Intel Root Ports or AMD Root Ports or any other bridge from the
list which did not have any issues reported.

