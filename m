Return-Path: <linux-pci+bounces-27631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53373AB52DB
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E8A1893D97
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B427055F;
	Tue, 13 May 2025 10:25:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65F26AA82;
	Tue, 13 May 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131927; cv=none; b=hf41lAaVE096BeYDFsNtYFUkyo7mwO74dbr/z54rBhHCoute98n/nkqivRg0pV/+PJin2dp6Y+Sy7KsbdS24BuZ8+MIw5tIX5jUON8GnChWikW0DHvrkqWt0tvZqz7a5e2XBQLFDzjrsyIJDSK4Kjd84+dlJHCybXZXnEWJwJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131927; c=relaxed/simple;
	bh=B65GQIOvwhuc2wG4bGcyeXKgb/glSGzLq/nCJcTug94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okEce6//Bi4LEkp0guCt4bFgi3pa361J100IclPhujOIpphVINz5zbt6MPmqXbLu7Z7pHBOEf7azvmo1HUgxYI5eGMCGd4k1haFyaklHa5+Uv1SunrkpqLh5Yd58u/iZVyUY9n2MaPNFNEJr/XyC8UTXkC7nwxNXi1lbbbrG/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73712952e1cso5366653b3a.1;
        Tue, 13 May 2025 03:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131925; x=1747736725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu1MGhXj5I1mhXSeVHZqWhuT248q8j49CzHBBK7frdY=;
        b=nB67ZPutSodddGeN1JBpGufhlzJkEUOwI3/ZSW6gIv/R+LH7hcrl2fsBqk0coQ+569
         JhQp7QrnAVdlFYVyfpt1hxFLT1RnUiAjwzTsz/4oqHjxBt1z+XEFXvc3W10h4m6jCxii
         RwNXlnqrDtyK8lEY6uQQbYanqwRSkAAjNhfP6/z1IrJgqOSa4GoQNa8Ba0RR/TpcB6m6
         GdNZN1PDpdgW7wN0TEKa1b71vmSvRdj0aG+J/eEGDSRpycNuUJsqpmYxD2DvGOK5p8RT
         nhkP9d3qqI+u0t3X8T/22ygqW6Yn2SOKhQ0CdMA67frShU6LqG3xZ/e/q+XzopA46bkf
         7w8A==
X-Forwarded-Encrypted: i=1; AJvYcCVmimrRFVMrBrQ2Zn2OvFtSmcdiLYNLsvOa/GdoRjf/5jh/vzD2CEpPnMPYcQ03EHxz1XHAUm+URJc=@vger.kernel.org, AJvYcCWtl+v9WU3lkHF7VdAasQeFy4zE6ZgJXSZ2cBM6sDcWNQAF3cA8aKfN7M3f0CsXwqnl7a8Q9YWuysakbRhKp4ATzSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPg65RaPco6LXzZZJyhGIlkXuq5FrHcuUcXRYA9c6r9oDNldt
	4QtN48cbX32a7L0lih1WoPLDlL2lNpUIm5nGKrBC+/Aw1kNYJt1Q
X-Gm-Gg: ASbGncsKohDwplmlWusvAzXIPnZqRPCLixfItM/0DHHidR9dVdPO7uvsoyHGOTZm6nQ
	EzxgDJBgzZbNIJ7nY6eKsOMwIb9ueuNGsZQPyOEX3KHyLzMpsoGCdWdY/EcRmEVbaJ8OUn3jdqV
	4qO+5Kv3yilYTh4Ll/8D+bk9JfgmjKITSih2LwZLCC0R6Eml/Y94zBmqZA3JmTsTzdg3yohYALL
	x3WafBFkZzQYFGJxMp90xz2Hbp7qmHcGuF2JqdKeF7m8uLdPAb+vAXznOoQ+jjrQP2FCKwn6iDv
	IM3R+f68JJjqalvE9WYpurxo/Qdonq4NLrLW2Rk0AXbzqSex0JdSNJZ7Gpx2y/I44jz/VYHrjk3
	NyQ36DdvvE7ACw9ZKdftW
X-Google-Smtp-Source: AGHT+IHgkbHZ6vMrXJ+sz5YsVjInhm1h5+2wTuSy//t/gr3IwKHBMkQrJvmGQ6JKu6VeSx7VxR7jBw==
X-Received: by 2002:a05:6a20:c6c8:b0:1f5:7873:304f with SMTP id adf61e73a8af0-215abcb169cmr27543835637.37.1747131924739;
        Tue, 13 May 2025 03:25:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b234ad3ea55sm7013073a12.36.2025.05.13.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 03:25:24 -0700 (PDT)
Date: Tue, 13 May 2025 19:25:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] PCI: endpoint: IRQ callback fixes and cleanups
Message-ID: <20250513102522.GB2003346@rocinante>
References: <20250513073055.169486-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513073055.169486-8-cassel@kernel.org>

Hello,

>   PCI: dwc: ep: Fix broken set_msix() callback
>   PCI: cadence-ep: Fix broken set_msix() callback
>   PCI: endpoint: cleanup get_msi() callback
>   PCI: endpoint: cleanup set_msi() callback
>   PCI: endpoint: cleanup get_msix() callback
>   PCI: endpoint: cleanup set_msix() callback

Note that PCI prefers to capitalise first letter of the subject.

Thank you!

	Krzysztof

