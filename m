Return-Path: <linux-pci+bounces-33740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7FCB20B5D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39776167D76
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3920F07C;
	Mon, 11 Aug 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RPomDGHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAD20F070
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921453; cv=none; b=JubXoFX9DFWR36NVADvNM1Ywu0GzBdhLoao5S8V56QIqrY9IpeuH27qW7sEM3j2Uqv7yKVIb+h5yHbXeVBJYCkotf7eEKUe1L5lbVeBDVGRtld9RLSWbh7UtZrabHL/R07U2jIj3t506XtDSl32vmjDMCGoRpIjkHssdrWc1DdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921453; c=relaxed/simple;
	bh=H6l53B4wZkFz+nYR8PTiIJtmbUzH50h27nGG3cRI8Sc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tKU67643rENvwurgknkAsCBjN/D/aWfBYhdueDMZdKIaoITCnC2fgaEa+f58IbpNR4Lwn66OR5ulUV+BkaaTHrSsAZhHqPYREor4FXfr4sFTvhefVeNneClgYykXBHuKoEw/1ZomhQPX2D7FHgXeVuPJTvlgDAIlNEgb0x/0rjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RPomDGHs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af91a6b7a06so743287966b.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754921448; x=1755526248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohexk0G5qQQ/U7tEXowxhsg85cDA9yyayQBpZFpm+6I=;
        b=RPomDGHspqrOA99cpDwb5F73hsjuzh3Ibdr+JNVUwjiWOgn+kJGmAMEzJQc41jXwyP
         rD68hgO+XCuL7INKK+L6bWexxcHiNE1zQwtKyJiLEprc4I9taRgh3HKlUpBnS8Bj5qmM
         kjiJ5B4gpBJ14eJPSuyYF6jIpnOaSL5w/0mW37PKRWdfBrNKu441QnK40cr5AMU0siXK
         xSq0X1FoWiX1lF8+xzi8vrGMuZFOuq54WNWifxwDpf0My0xIt7CzPkbmS8EBcRjrxSDz
         MGXfLVBBliWkYw8dQxVyZPV5rUBv1ZYkdWXj0mi7BVlSSBl3Pv893cMtn/VldPtWQliT
         DO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921448; x=1755526248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohexk0G5qQQ/U7tEXowxhsg85cDA9yyayQBpZFpm+6I=;
        b=igu4qYkpRVAMbQqHd4EyDjzKDbXFbx3Zsau/Klp7+9da90lWyWJbgWTWFbLczLHCLR
         Yjc+rmUavA2CFvn4EixqGkX6vg+rpROGi2p5sO5F9xIsEqTmIDwXM45WfgihEeelpLld
         gVZNiQfCUELlFvEF/9OTHyTE53NZHuiaAnmdqLf4jb5JSwDzCPc/GGsaGY04OmUig+zM
         EAEoM5wuizuL6+s4GKYQnd9lrDnep+p8db/Fy3iiTK+VYZ+R08JkjSbza1FYlvFZSRgw
         XctvEwDCo3uVLIawIWB9mdyrSHiLUqphQBu1J1iv7HivzNTZMZEM3aodQarKTLW8L7C9
         tzew==
X-Forwarded-Encrypted: i=1; AJvYcCWSio560FeyO3t2nOQqdp4flN1z42lW1ew630xst5lFy+nun1Bx/Ck0PVtcdyiggqM68+OcSlwNdOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfPlG5W4WZ63+OrAgvrxwCcl0SW6iJxKwNAsjXhl9ATR+t9CM
	NK87NRGWXR2VOJAvRUaPoAZ5Su9W5dy0mGJaIyen0qMZL2fHDNUKL+NWEZGBQsM5FZc=
X-Gm-Gg: ASbGncuv3DZOEQmrHrs82xnJ2gydN+wwJDzBupv0Lo75t7uRXerLRXdERCtUh937ghg
	Smyp7Jdlxs0JjKLefNYUORfoEZReQ8jvdhaRRpCZ1bMr3fdGQ3qOUJJjpqqPaf/Xsf6bQCFpQhS
	0asB147vzxf2rknmXrjdVU22g3D2/ygu2krcG4VPhITA6kNosKXzjWgGN06NqcGJFZO51zjvIuy
	cyK1kJqG6KLdiWMHvebWxMrSRNnjYZdAZqzs6MFzUtg3aTGgBcylUR8xXRmXHOiMNjDS1map1oA
	zLWGHC2k/hB2G7NUXsOWchDEIXWVgjgJnb4NPZcwPqpmw/gf+jQQ7ojOCmxd/O7LKYlELezw1fR
	Jhl87Y9EkXO9iyLlR5V+uzbsanx/+Lpx/tSObbbTImgJe51XDAeR3LGiuCy+HcAn6jw==
X-Google-Smtp-Source: AGHT+IHdBKFk8Hdz0O5Qrkqv+q1AVcT+ToZrNVbbDng2NMf7Xf+fMHPhcyvkBGiKagZpBw13o0Tyeg==
X-Received: by 2002:a17:907:c1c:b0:af9:71c2:9c3 with SMTP id a640c23a62f3a-af9c647bce8mr1317574966b.35.1754921448512;
        Mon, 11 Aug 2025 07:10:48 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23bedcsm2030552266b.120.2025.08.11.07.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:10:48 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Subject: [PATCH 0/2] Establish the roles of board DTSes for Raspberry Pi5
Date: Mon, 11 Aug 2025 16:12:33 +0200
Message-ID: <cover.1754914766.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this patchset is composed of the following:

- patch 1: just a cleanup to get rid of duplicated declarations in the
  board DTS for BCM2712.

- patch 2: explicitly states what BCM2712 board DTS will host the
  customized nodes that refer to RP1 internal peripherals. This is
  important so that followup patches add the nodes to the correct
  DTS file. For more information about why it has to be done, please
  take a look to the patch comment.

Andrea della Porta (2):
  arm64: dts: broadcom: delete redundant pcie enablement nodes
  arm64: dts: broadcom: amend the comment about the role of BCM2712
    board DTS

 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts      | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.35.3


