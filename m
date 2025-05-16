Return-Path: <linux-pci+bounces-27861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E3AB9CE5
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78758A052B5
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D9241684;
	Fri, 16 May 2025 13:07:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63824166A;
	Fri, 16 May 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400824; cv=none; b=UaThW6lfxadbAMUjrJYEQ+wzh8+Hu3vccvH9dDJw1y7vY8Z11wldwiyJgIZfojNcpT3Cbz5uqwfZlRwFJGnhDNN+YE/qlE+B6LeB4GoGeVDXe9IG3YQ6o+i8cOHlw3YhHaTPwF6+BHM9v1DUsJEW4PV1ovL9ZQssbZsUXjpPRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400824; c=relaxed/simple;
	bh=+0NZ+sWnbKsgSESa5Gbs1b9Q637JaLf6BedosU0Tn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxMKKSUyPRKn4KJS7enNRv+VmuM6ssRp9z6SuPjbEzzH9Qt7JCP9klkS5pagcJJ5te1ARZwhpAj3z4z5CIVcN/QCvtA5C+cRCK7fU+ra+CnolNUs8eW41wjh27KpGzULaqSBy7QcvsPgQ1UE+L09+Oa3d3xwSmehlnxjdsgSssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so2534795a91.2;
        Fri, 16 May 2025 06:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747400822; x=1748005622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zp3vgE53Muk/3PW9+/KzJILekMj3FssQTol1diFaQM=;
        b=Nhy45Gl9c6CmIydc1JUpAyL51gqA/j5FtUbClkIIlWIQTYP5QCek6HsifpMmUQMpNR
         WaCT3K9FCt1l+KNB+oDXCZ6A99wP2VbsSvjtqNvGBWuKqX1fyusEYPAlcoIWwziiZS3I
         15pL1B4a98yFdnm6WHQkPpZsc2LyxBgnYNFBue7eW7QlN7SgA/fchvRU6bVPVUBYp1CI
         i6CjDv10kM5HAvzvXsLlbWbH2nbzKzJXQinS+4WN2q1a0TpyGKspM8CogjvPE7C9ttln
         Hr0w8m+0zLyKfcUqZbDFFk9yHf7zXJUGwLqcwSDRAbdzbfHMUbRmSbDIbU2Rzx7VgsF1
         tdJw==
X-Forwarded-Encrypted: i=1; AJvYcCWe6nGJHjbu+d/tj9B0AafXVVrIOyoElYyHZrpJymmLfgh6EcShLvcuJxGtF3tvBl7beq/iC+I1x94L@vger.kernel.org, AJvYcCXilw99JysMrsqgg2oNEjF4ISlGAL29z5czfVF3kno9b15IJX/tOBu504RImwgzzvcTXpRtMKrTJh/lp9ln@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGEhhRnbGc1W+GycQLbeUTvXt+kER4MLItePaowRiRdOdoVr8
	WVeD1zZpgVCrKX0bOTfsaqcYeQFccJvTX3fMs3Ip8pzTx6Lyv5ZOGDve
X-Gm-Gg: ASbGncuIw7qAzTbeu7TkUWkfYQ6ElytMZ2JciZHTJz7yN5H7i316MrQGPBm8ROfC0hv
	syVMG8hinxZknUvlaHVTVY7GOTh5gvvLXDj7v/6RZef7iqu8XIFxR21fOplg1QDmMulTOUqXTID
	BngXaq9pEcmlKlA5096QibD1Rf5X+6jCppdXwQJTNFNk1Lt+USnrILkTyVpillmIlRAg3AKJM9E
	XI+G+MLdmXbKmvOKaXhQFUMToqOI78hoW8QHtA7kL3qVNjzmn6lRHOnBOmOQBGyL4p8rGQC70Z6
	x60TFW0OBxBd0saMUhZbtq8imqjh4an1Jc9htEBnpYezM0O0sQSSs5NolOJPiybNm1f5UVDhkC7
	rKaFcikyGbA==
X-Google-Smtp-Source: AGHT+IGHRK0J61dIv/5+BajAmQAkgglPYZ06XWswzTNMf5+J5oDjNoiy3nq0yQqotG9du/eupTzXPQ==
X-Received: by 2002:a17:90b:4c85:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-30e8323efd5mr3100395a91.34.1747400821398;
        Fri, 16 May 2025 06:07:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eb084428sm1492402a12.57.2025.05.16.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:07:00 -0700 (PDT)
Date: Fri, 16 May 2025 22:06:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: PCI: microchip,pcie-host: fix dma
 coherency property
Message-ID: <20250516130659.GA2084811@rocinante>
References: <20250516-datebook-senator-ff7a1c30cbd5@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-datebook-senator-ff7a1c30cbd5@spud>

Hello,

> PolarFire SoC may be configured in a way that requires non-coherent DMA
> handling. On RISC-V, buses are coherent by default & the dma-noncoherent
> property is required to denote buses or devices that are non-coherent.
> For some reason, instead of adding dma-noncoherent to the binding
> the pointless, NOP, property dma-coherent was. Swap dma-coherent for
> dma-noncoherent.

I have favour to ask.  Can you capitalise (so-called "title case") the
subject when submitting patches that are PCI-specific DT bindings?

This is the preferred style for PCI, at least at the moment.

Also, it would save us the need to do it every time. :)

Thank you!

	Krzysztof

