Return-Path: <linux-pci+bounces-72-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5037F3A8C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4FB216F2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB419A;
	Wed, 22 Nov 2023 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WQ0Bw66L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206779F
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:02:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ce5e76912aso39637895ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700611345; x=1701216145; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tinH49dKaKori8Oo1FO1JsnBXM1Z1NchwQc3U2somhw=;
        b=WQ0Bw66LAQzUrrBd/1LhIvWMg6fr5JvgBWTylgWXL1N3dPas+zqJq8jZ5vf27l5h9S
         X7dhnOxxjQxuU5wgn4YhDuK7iDNXHWYVYKu2YofHrLpCXaJD5eZIg8PH6WiQq1qy5V2D
         d7JYaTDCvd6yA7k/avIaPj8jkE+ertN6AE/xelectpMXj5G0bAzsv0ArzDE/MKpzV72Z
         uNNWL321XcwykmlI6PAcgu1NPdvDmnWPD7STVMlO2HAYv23MRIlP5cx1W9YwVQ7d6s4A
         ASTIOBTA/OVbTycBU2OUdcbPc32JUbsu8CknSrrUzVxClpzZg/Nq0M93+4BbgYTNtbGf
         5o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700611345; x=1701216145;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tinH49dKaKori8Oo1FO1JsnBXM1Z1NchwQc3U2somhw=;
        b=IydqXoU5+nDg7MkwROx0Rf5VDThLVXTBk1ecB2ihKXLqPlR82KSYt+Y4ZDAiJIYH+Z
         7GsKvYpovwySY6Hgdc5RMtmXbHnfRonVRioSDeBg0ZFub+fEMBNm+B8f/AfFZYM9jgBD
         HnGu/6PdtGZPsGFTMzBM3h4CQUCH2J744KNFLnPSzIHi8HABxgMboqt0efGd5b+awJy6
         U6x2WZH7bZ+g07J4Kd4PyqxUJ7BC2wsLPuUOkiL7Lilx2ZESu+bKOEk07CuWTZVqGuny
         Isk9VsWKinyxi/DX5N0JAX6ibM+fYCNfM+iaXY5hxRLcxwVPSYA1A4MirfY/vLOCg+Ld
         9u9Q==
X-Gm-Message-State: AOJu0YzSDdPldfW5FsCViMv/5ROKGnZ1LkRr/xu7XNhCyO/JNvwTsD2L
	jJwHTAYksgetdaj3mL705XASXG5qlUphjyYvzpE=
X-Google-Smtp-Source: AGHT+IHPSYQ9AO/BcPpoAtJbtyVs/eyGh4sUlTPWvu6mJB0eRUU8qpavSJIQttbInCGE4o9/JU4RwQ==
X-Received: by 2002:a17:902:e88e:b0:1c7:495c:87e0 with SMTP id w14-20020a170902e88e00b001c7495c87e0mr867326plg.37.1700611345532;
        Tue, 21 Nov 2023 16:02:25 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001b896d0eb3dsm8557681plj.8.2023.11.21.16.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 16:02:24 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <D34BC819-ACC4-4709-8464-73EEDDC64328@arista.com>
Date: Tue, 21 Nov 2023 16:02:12 -0800
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <581038D0-C2B6-431C-BC67-5DDE9458FACA@arista.com>
References: <20231121184008.GA249064@bhelgaas>
 <D34BC819-ACC4-4709-8464-73EEDDC64328@arista.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Dmitry Safonov <dima@arista.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Nov 21, 2023, at 3:58 PM, Daniel Stodden <dns@arista.com> wrote:
> 
> +       put_device(&stdev->pdev);

That was just a sketch. Actuall pci_dev_put.

Daniel

