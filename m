Return-Path: <linux-pci+bounces-12883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811796EB42
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0278D1F25BDE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E313B590;
	Fri,  6 Sep 2024 06:59:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215ED13EFFB
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605988; cv=none; b=Gy2kPcWg+98YmIyI7rkw7PsVO/SeHIl7HHFl7JZgUj50D2iHhnGKQ503qphGVRB967fyUa2/yYB7OZnUL2wPqfpPT/H3QdyJqjWNotFNOxjCLCZeh7iNMvAlxB5J9j13pwDvXmRjWZBklpK6nos52Ij8m41A0UbWyTsxD1uCPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605988; c=relaxed/simple;
	bh=BdICQT4T2caPIwx4Sc7CCmlaqmcoVI7c3nR1UGIkzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG2sKItRYl+ex1FDL8mWQelB5wEq74Nl5lb97SCGxSogIXuFFnhI+BpY8o4bghwCxGF+DdB8Ahslo0UzZjaA7T+4fDZ6nIm+nZhGbPqAix8Fg9sfJhrwwzoJbyTupn5XUEvdYmFcnaxOtK0OTfQ+waFqT5p5ed6I8MVuCRh3g6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055f630934so13091845ad.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 23:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605986; x=1726210786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRqsGvPMf0kaVsfNahRfv4ncZawgOeknWZkJxhB5/qo=;
        b=Na2y018XoEernEk6URi3MRPk4mCOU280aJv5LRE93k6ore9ODn00WyxAxiDZau/CX8
         pL39FoLBC4qvFXog3y2n8faj/s3JcXwq77EelwRMX8/1btp/uiwwtc1Zf+O50kVMQg1b
         yaeTYIpP82L226IBgeo6s6IsDJxytHSuzboSTDIgo8+jxp4p6jIfQVhuTb+HFsSpbhaE
         Ytno+Smv3oIbGQZ2v8ZL+zQ/nvAFTxPeI/WL344c1ccEHEaoku15yM/kqUnFKcvSb8XI
         nCLbiNcDgWJrgS4GrTJnC2mBep8KG5mt3rml3PuvvaYyj5n7eW87gcv8Q5tyARdbLMiN
         aHtw==
X-Gm-Message-State: AOJu0YyzvWqvzuMtjodj2tCcYKjjOPTVlVnXTQlcag0OYnzcFYvLUXum
	U6yaCL3YmcKYWuNhMbb7tp8sMcwM2vZFLaqGx00ncVM5AzdbJnQp
X-Google-Smtp-Source: AGHT+IGlPbkaVimtbX8RI3zuUhb2aV+HobIZh8jOcT8p5obLGTpWlqRkjtk4wnstwdun6sB+oFcxdA==
X-Received: by 2002:a17:902:e54e:b0:206:c5cf:9721 with SMTP id d9443c01a7336-206c5cf99f7mr83396745ad.1.1725605986183;
        Thu, 05 Sep 2024 23:59:46 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea392eesm37797125ad.179.2024.09.05.23.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:59:45 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:59:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Export PBEC Data register into sysfs
Message-ID: <20240906065944.GF679795@rocinante>
References: <20240904030035.284423-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904030035.284423-1-kobayashi.da-06@fujitsu.com>

Hello,

> This proposal aims to add a feature that outputs PCIe device power 
> consumption information to sysfs.
> 
> Add support for PBEC (Power Budgeting Extended Capability) output 
> to the PCIe driver. PBEC is defined in the 
> PCIe specification(PCIe r6.0, sec 7.8.1) and is
> a standard method for obtaining device power consumption information.
> 
> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information 
> has traditionally been difficult. 
> 
> The PBEC Data register changes depending on the value of the PBEC Data 
> Select register. To obtain all PBEC Data register values defined in the 
> device, obtain the value of the PBEC Data register while changing the 
> value of the PBEC Data Select register.

Kobayashi-san, we are missing the ABI documentation, which is all that's
left to get this series merged.  Perhaps even this cycle if you post a v3
somewhat soon ish. お願いします。

An example of a series which shows how to do it:

  - https://lore.kernel.org/linux-pci/166336088796.3597940.14973499936692558556.stgit@omen

The sysfs documentation (see section at the bottom):

  - https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

	Krzysztof

