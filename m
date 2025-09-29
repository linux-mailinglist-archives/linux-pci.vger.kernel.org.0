Return-Path: <linux-pci+bounces-37222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9704BAA3A4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959421C6FC9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B1221FBF;
	Mon, 29 Sep 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CzrucTx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38C33EC
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168115; cv=none; b=MFnMm8kvh0w06IgMW7QE21epvekrCqwJIbpf5perstYscslCiAGSBX502W8uM+FWHCH5HIjrl0D+jNugK9dJuUXedgbhVNrinH1fTwVy+jdFKiANG3hA+kGtumgfCpZ9L7vaX6RgSBlXypF7cuhZ6nbY/Cm0JKF0R5U5RG4ogNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168115; c=relaxed/simple;
	bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVuprhlsnITqzJMx1uBlZrJHpuPDPanTzUVwgV8g1FO2eyyB/eQBBvZj47qaKxDErA3Ty2P1CHpck+dQ0Q2AyViralojpFjbysg5COm3tZkyI0crMQTnHVu3lIF6Ru/3Xxv890887MadmTzt115VPq6UhWZ6EzlxdQo8kuxyk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CzrucTx2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8571a0947d1so569700885a.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759168112; x=1759772912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
        b=CzrucTx2AML3apsay/R6zfQRcgeHyoKyJk9oJ4aakLT6HDyyWWDSl2/cIqfjovU+56
         ynisXgpHx6Y4YSRnlB7XGbR8MYOqUxx43+zb77BW5Tq7ybDA0/CxfI+xDte2E9rnqUCZ
         rcOPV4erdHds1RLMLwZXIeFnKCV05no9LlyyMjNmWNDO+5BEkmu+JSlMh2hBtstW14jY
         fy6Vp5OAqQAtrUs8TFwoAyH7wPwbgOhX3ooaIoZPG8pDhO+TR7CzJiZ61dqsCKt8O1/V
         1Q1ls9okiX2QgPmMi2eA7BFRjJYdVsJ2lj9JSdNXAQ3BI2zwm58cZl/jElBqClShl9T4
         YTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168112; x=1759772912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEd6qzox/41lSLCAphd0FtsEhlSfJUwHBBvP4IfW7Sg=;
        b=leedSlt1PaObLglZJZoIoybcchGa35Ab5logPqLub7YDxBQVWbyQZSoVNtudTYzh0h
         WaCdkoTGVkSucCxyE+BpzjcHKu98WE9UrY/DTtcWX16aV5suhUfHI64qqj4uMLwvq4J6
         lwXcdil9KeHsEnHCwpiA7lNP5S145m+W6lo9798RbSEkt92InOpxSJsq2eC3GGtr2+0H
         yGFrcG60zbTCKzRG1Omh3WYbX7j43yprByozYC3qkgNOTDkhQv8CfXuHDBkKmFioNyus
         RJJt/js7wAq1gLGpsutg45b0W5Q84E/iniRNadSxYSiGgaU1aQCQK9OdFaNg72U5FHCg
         OnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCKlhhfN1/uiJisvyt6mcQ100MQJ8P80z9tNUEX8NKEkeJ/XJNCloykAy3K65eic63ZspjLCF/R6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1kEd09s267WTXWQ8Vnsdt3VJt6dElAIIWUAYOS0qT6EI3hp0
	BckIRydCFGfKOZ41VtKHekXNIBQh0JHDgsPSroELlCmDrY3advTEVA3aD5GUpo0v0GQ=
X-Gm-Gg: ASbGncthhjDfA59QIGQHKJmJEaCpmGPlcp+aeZVLLg165lulIvkAnXvkv6CzI5Y6O7n
	gXu544ZfaEyKIDoAkKDdI7fej2RXBtMqZfkzU+7DErdqb2mvUoDmn4JKeNaBjA8Hj3USl48pRG1
	ak20SlL62c++TRc4aAwTprN+oywWlLSgrSMt+hWAGUZDsqKr34RyH8s3N1GQOEMDpr8YPCyLQHF
	5WOnkaIY/Ktb6S1HnNjuGJjJ8EeybuG1RtWBX5rNrJyYwFe3hLEKcR3I86zaYZft6IBsHm8AyQY
	YHxzaP5aOET6XLBDSGg08Jd3zS6SxnNWaHfmVnbEtjfLBGf4n6KEe+DKgOLoVaxBmeBMUJKU
X-Google-Smtp-Source: AGHT+IH7JgDZfuxGKutkR/096no6VIsmYTbq7k+Xr7PvDap1YLRs3fNqi5olsRhXpNbKfmVCs4Vrog==
X-Received: by 2002:a05:620a:191d:b0:7f3:c6ab:e836 with SMTP id af79cd13be357-86eea4aae1cmr207366085a.18.1759168112279;
        Mon, 29 Sep 2025 10:48:32 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2a1913d5sm860075385a.31.2025.09.29.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:48:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3HzD-0000000CNlZ-0253;
	Mon, 29 Sep 2025 14:48:31 -0300
Date: Mon, 29 Sep 2025 14:48:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20250929174831.GJ2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> After the list of preserved devices is constructed, the PCI subsystem can
> now forward the liveupdate request to the driver.

This also seems completely backwards for how iommufd should be
working. It doesn't want callbacks triggered on prepare, it wants to
drive everything from its own ioctl.

Let's just do one thing at a time please and make this series about
iommufd to match the other luo series for iommufd.

non-iommufd cases can be proposed in their own series.

Jason

