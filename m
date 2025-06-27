Return-Path: <linux-pci+bounces-30939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC5AEBD03
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B457B3F6A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562C1A239D;
	Fri, 27 Jun 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bZao6qC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02A1A9B3D
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041246; cv=none; b=sQyaQThuMnWutoCB/uwuZ1YJuoKlyUeJL1TatnRCw93+PotmMiE6ME1Ntnn0JGvurw38lapQa/NDiymcqHyvWCRzu9iWAvPkKmoAdDzdOvL4ksKUrnU+KlYoaIIbbqmGURwhkdEII+k/LSe9XOzaSe2Zx5dNO4LBKt7iAd+9ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041246; c=relaxed/simple;
	bh=P/9Uu35Gkg3pzrei9fhQIdo+nEeR7gFJ/ClbdnhAWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEIoRgbF43Kk8r72jIxgQsv8dd98B70TYCOBnxG7hWgdbRKSN6ydyjb8GjOfNIRc9HOIfEvSCdzM9LwJcpPPe3Pz1/vE14GBIbHCF5hd8lFg/dXLqVAA4LKh5OsjQNJIX9c7KAfdbt38pdqZ0xRcurWuEp4QECzxef+CdtOUsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bZao6qC5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1817083b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751041244; x=1751646044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZq2fP6qW77bTzv4wncUdzU6bLBOmeOJqXYf3pOaHzQ=;
        b=bZao6qC5+emeANvC+7i3rFpE7iJtG1SmJjkLF5i3viCVPh9g1OfotBWk9SInXdmM94
         mgo3N5i652XJ+cINUk2UAWW5wYBjKWk6FsIaWMYimXC6QNVWSisFei4PGL1EjkMcCK3g
         rz7LS7vj6bG8/pwzCOtOcmBb1utIKBULiMFgmHd088bMQIDAOamZMXPwWGyGIqiKRB/j
         lcQ7/Yp5Vuz7xf/l4s5i2UKX2s586ZaOVM187gCIX/cyfD20BU2XzBh4R/VeVTfUtmHc
         lD5Vm2rQAPx/Oi4tJ+zTaARQcPhdrzSGs/QHcgwoh93LA9n4xS2o/B1E/jfG4KifpO4O
         BQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041244; x=1751646044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZq2fP6qW77bTzv4wncUdzU6bLBOmeOJqXYf3pOaHzQ=;
        b=smYigcFKgfblx23XXoKhQmf4Ql55DaQRNE2poytnMO7KiTxuXEaujYWmBgXuQLngzD
         5dznZSdB78uSI8LUv8k73wZepfcvgKLGdOs7nQ2Aei69ixQaTYlFR6QE2nzQ6NpC/hGq
         2iXIAzGJ+uHcKSkfrM1Dq8YK3lFTVU6Vnc6bQ3vDi104rBAEJpEnWVO5zVC7GDbh/jcW
         DxuRBDI2Qc70uLmQyGuvpy3/YtTqwyNq1t7SidhxJzVs0mQ3DRg69Ip1PKC6BcTQUt6o
         m9uV7UgauPG8CO/qZCSoLa7hMETumeRO6mq6JYs0dK5qb21iVOJxwf6f/SpUFuwDDwYW
         gJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbMANBSJDwShZ0HanvFw8E7FvdBayafDE7NwoAxlDEadiBXEwd8dEA8HTj5IwY4bMGTPggrxV6a1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Hlx+MT15fxHgbgEoIsV4kvuoQpSNZhwY8SxqoBPIhzTW+e4G
	uPAusp83c7f8BpE9i6K6o7gk/9x4Ji7gHQ1DyT2Ni+l743IwleSs1nLngNzGQVKpSmM=
X-Gm-Gg: ASbGncvGZlD6SYp6L5pfj/4cQjZ4UFycHm9PpNsk+mOLuyFsCaPA1voaOcpUUphjXyw
	Qh7giKCHAtFZRcJ1uqvUlA8c3FvUbDyVwDN9OYzEysacDPj/lzaQFu/edcUiNAqLCW/xEgxPJ/n
	PbIL1oKnpVPMms4pU6BzEzYQzr7F2oC2ElQ4sd1YC1WuKhnhfjFwU8es/tm3QIjBvfevX/9lcXV
	dWJxds7EN+Zmix5ReSEiLEqqu2bPBhp+1sSPA7AWTTjwfbdik8c54J/7mlQpEiNmXEkyfmi8Qfs
	sFV0i1+ZOBCqf9JxrdbwmZIjzJTJLy2CO0TOSH5CiNgHzCcEFS4HEuKSvMQxFX07gfVl7ZSbbqR
	j+PfV4Gnpq+Z5
X-Google-Smtp-Source: AGHT+IG5qhvoyT0r7ArrhDTbv3HctY/DXXsQKXJew/js8cQGhbmm+fWLmqRdV6UFkGbhd/vZViKVvQ==
X-Received: by 2002:a17:902:f545:b0:234:8ec1:4af1 with SMTP id d9443c01a7336-23ac19ab87cmr65488225ad.0.1751041243572;
        Fri, 27 Jun 2025 09:20:43 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb3b001csm19167255ad.154.2025.06.27.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:20:43 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Fri, 27 Jun 2025 10:20:35 -0600
Message-ID: <20250627162035.34307-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2506270140430.13975@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2506270140430.13975@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Jun 2025, Maciej W. Rozycki wrote:
> Have you verified that with a fix[1] applied for a regression introduced 
> by commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set 
> PCIe Link Speed") discussed in the other thread[2] you can still see those 
> issues?

When I tested with bwctrl.c I also picked the mentioned patch with it.
Certainly the patch series related to bwctrl.c & the patch you mention helped
significantly, but it seems that it is still possible to have the quirk degrade
a 'would be healthy' link. What I have seen so far with the bwctrl patch series
have been during PCIe error injection testing & the quirk running at the end of
DPC handling during pci_bridge_wait_for_secondary_bus(). I believe sometimes an
endpoint isn't ready for the link to be active again during DPC handling as
soon as DPC status is cleared & therefore the quirk may be triggered. One case
I haven't quite fully explained was the quirk running twice when DPC is in
pci_bridge_wait_for_secondary_bus().. It means that both
pcie_wait_for_link_delay() and the final pci_dev_wait() must have been the
callers of the quirk(), but I think it implies that the first must have thought
the link initially wasn't working then the quirk thought forcing to Gen1 fixed
the issue however the drive must not have been read to respond to command
register reads soon enough.

On another note I realized I left off a closing parenthesis in my patch... I
guess I would have to re-submit if we move forward on this.

