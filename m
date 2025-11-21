Return-Path: <linux-pci+bounces-41855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2BC783AB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985584E13F3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68B33F8B3;
	Fri, 21 Nov 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fH5nntOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721762F5B
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718527; cv=none; b=DFfAr7G55UcV8HiUJV2HIDSSg2k3a/srrLc704paFvmstTNVlygMdbukIX4GH6mA8FfWGmy2sLOIQNItmXGT7GGdPdQPU/LZmS3KtouQdYinhJPfS+q+87Nj2MEnMEiy9sjU2574Lp/zhldzWfk3U8bicdY+uxlLxgZvScv0vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718527; c=relaxed/simple;
	bh=LF9MKeVs28+QaTBPa9kw6A/uGUimzmq/sym5DkzrGSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r1V5WCgbjkXya/fXKrXRMhzrRyKE54YThXEtQEfYZjL/qp+/akyji7w3h2cYUGvwUBRdsGu+HtaqnHA2uUANcByfeLYrppDrPdZGj5lK2Ny/4GQSc66VvwJ675fKiTeFoOtHLnzH8l1YCcY1ripGos3BaMgZSDgi7Ywi0a8NlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fH5nntOK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b566859ecso1638015f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763718524; x=1764323324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFwTNwrNkn3J7pmdVYGrUPZZHawxAS2+qz7cGz84mvM=;
        b=fH5nntOKXOafhjW7dhdMdTdorEyLgocp4waNBTN1pfjfI8At3yPaQLDQwjlDwWD5Ae
         BAm0XxQ9poZxgn5Q316IJ4RTKm75lFr3MGtPn72gtSFDR31pd0Io5SeuIz3N8VMe/6YD
         MECV62tDpGm+Feg0/bZmhsersjUqDclQWMFP8vxsS3KzhWFJk4qcxMIDja/pJBBgEPzH
         XSZSnWJyDuqN0Vrx6NcaBu1n/8eza0vyzMC6rasigr74Q+xXPYOqLkerZFt7IPNg6ovl
         NWicPWOOVOetm27lFTxXiJ0JHSqxXjzv+VlC704vENClYmIYzrx5mSFsFDRycTZ+lfKd
         1X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763718524; x=1764323324;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFwTNwrNkn3J7pmdVYGrUPZZHawxAS2+qz7cGz84mvM=;
        b=D/UEdt1T2AIFjostVhg3y0SphLljSzdd3Sw7q3fm2E+X5Mq/VRpZ16mDdUId1i5fs2
         6AiaZ4U8I17A8yZLzQnIp6Edy0tSN9de42GusAvoyzpPZK+1G+urrNlhFWvsHal3HhcX
         4n89qeRubpch7Wt4YaBYGsxt1W80O8E6RgyrfhIY15xLVY7xREHDeOPQopC3ZR5Fgd0/
         acIPW7t/QOBNaqf+joolRGsQ5s7CGcnJ9C9oUhidl+dusvqVI6t01qcAtPXstsQShjip
         0Wst5OOmthPaVYK2CSGCUN+fsWSHkDfhbZwNIMhNNm8SMacStelim1GBbeF0ETTtb+uW
         IFQA==
X-Gm-Message-State: AOJu0YwusuiJUkDzg49EnWz8EQJuOAa8x+LD7h16Rsb3YD4vxMkm/lT7
	7MbRT4YGznAiaX8lNFBDWYZLeFWIrhKjBnourquo+NlvNNDUNoDq4WjuqnZbRQWiuic=
X-Gm-Gg: ASbGncsIEMAbTytlm+avgdeEsR/QeivnS2ctfZJ70jVeJSl1rXdaxnSdEsn03d89aq4
	NQHVSrznS7+Il3C6gh1DtO/wlFCJPytu67pJVTXxa/UK3RFGIXG0JVKG+FpMF0ETg+mGQnyMGi7
	fcy6ENtlTg8uYVTUCkr0mxuBYNJ8vwum4acvGOEzy41L+nkU4UYEsNxwgeLxT75n85jIGHKWkKw
	SWdGIps9OB94y33eVOeEHT0XFPhNilnVP+k5Vh0u2N1ALd2S163T3QuD3uumgfujXAeqJhiUDuL
	fkeu+5x+pWBbkA/rK0pv2X9ylIXzzkPUnwh8WTkuZw/1IOyBn2xiaUpEmoFpJUFaAFf7DpKYtEJ
	giHuY2x5rj6mmQ0PNRN64h17JdYFblb1/LKD/12C1efuLRMjKaoGKhEjVuLYx9Mu6MrX9ZfSXik
	Q9ityQsptvTQGKjztG2FxnpoLm7Ug=
X-Google-Smtp-Source: AGHT+IHSWd714QmLz7/+yc4k2WoFIfZVRy81NvvjR28HQpWzvHqJ3LdUtJ+oyKs5fTkj5K3qKZVSgw==
X-Received: by 2002:a05:6000:26cc:b0:42b:39ee:286f with SMTP id ffacd0b85a97d-42cc1d19e4emr1519050f8f.48.1763718523622;
        Fri, 21 Nov 2025 01:48:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7fd8e54sm10185789f8f.40.2025.11.21.01.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:48:43 -0800 (PST)
Date: Fri, 21 Nov 2025 12:48:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [bug report] PCI: Add pci_rebar_size_supported() helper
Message-ID: <aSA1WiRG3RuhqZMY@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Ilpo Järvinen,

Commit bb1fabd0d94e ("PCI: Add pci_rebar_size_supported() helper")
from Nov 13, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/pci/rebar.c:142 pci_rebar_size_supported()
	error: undefined (user controlled) shift '(((1))) << size'

The problem is this call tree:
__resource_resize_store() <- takes an unsigned long from the user
  -> pci_resize_resource() <- truncates it to int
     -> pci_rebar_size_supported()

drivers/pci/rebar.c
    138 bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
    139 {
    140         u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
    141 
--> 142         return BIT(size) & sizes;
    143 }

So here size could be negative or >= BITS_PER_LONG which leads to
shift wrapping.  But also truncating the ulong to int in
__resource_resize_store() is not beautiful.

regards,
dan carpenter

