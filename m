Return-Path: <linux-pci+bounces-36730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DFEB941B7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 05:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E047A3DB4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72725A64C;
	Tue, 23 Sep 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OHg+a34F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA3253F20
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598154; cv=none; b=dwv0tkY1418+uWEDS/2zUHTNdfYzSkPCrdZUciDGFH4WBo0YOM56wuT/yAaZpv0gt7qqjCUJilRaoAxm1Z8POLTCxtLflPlu2fuJHcCwovI5eZT/nr3vvp3eqdyUgljdKgcjFSl2/UHN6ornAxIjoNsQWbIZfDjHkTP/FKXSfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598154; c=relaxed/simple;
	bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3js1rZOyo7HIbq481udj9VtnIAUb99FKcTMDOi9VMr8JxBksjfPILQNYUVcHusBi7nw9M/UBFFvWdxNpO2Bz0p2EWKJ4gPK4uinAJruqAWl6UnEI0BFfS4fcLS+GIKTrV+1FPDOGKr0+zVd0GQ8vHucdUTyj00PMhxWMVM9qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OHg+a34F; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88c347db574so165670339f.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758598150; x=1759202950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=OHg+a34F7gBNu2ln4g7T5ELLoqz3SFDECE3JAY73bh9zSNypV1NwXD9LKPIrfPvp0A
         US3QilXd+5TAy/oxA4KPelP5X3ofIk1IhtMRdhCx0FwyaiJrIuEjt4lpMqoyUZuXCekz
         Y8or8qUXxgro2LcFTqSWBZkgc1/kjqWlQTe7Z/qytpKM9sO7V2fZA2SzI2ypKh6bEPbU
         jJPoBMeQwzMmEaIbnbq8vPUAVEzl1Ufv8Orm/rnIGkTEe5Zx8igsGABnvY1PITE8remi
         n1DKSa1gi9QHXViMb9QRpMUXli8bc8u3tJZt5Ua8Ja0Obh1/wMyUc/eS5vble7p2zSlx
         Yn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598150; x=1759202950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=FVzPOKRQOCjShxWnGpO9xhmZenFa3SHr8N6A+4vAza13Sy0GZH4EVzGfRSZ09JrwBZ
         uX6ykYqho/mTaXiABsPK/22oTafMIQd75M8inG9x1+mbBJzQF7MJxJKAyF6M1le/N1It
         89tQ1yWYTC3kgSpoaKgD7Cxff4b4LzoOMV5YHjIMJsJEUgtBOd+YrN/iBAniMCagJaCt
         hvmc6epoh/ha2TBdFXuwM50L/Gu4wknfAMcmyLdHGcRgEx3a3NtkHvXNQdE89zJVPBhX
         FDagJd6Dw6ykIvU+lC11Kc2Obq+krNsfkL6caA1J0Ovm+x5sYXFefWlVc9mVU+NPtOW7
         AkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTOjud91ZqCxT+mMlZIuPufsHZzxleH4A089kNsGmgDIdj7qs4vr4qgw78sP6ojiOP5FWxA4TvY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08NK15AjQt5pshnSWeKhJFomJ5vXdkMhmksI9lQzaBVBMTUj/
	4lOU+BaIkjBXGW0nQBbqG35hEAhyOOKVQrTS6joAOTGAdZ8Cpn2A1v+cXkNlnxk/lck=
X-Gm-Gg: ASbGnct29FBP8N6kJCZWxQNPcUMgqmF6KyfT3ATuXeFDBcM13xuX2hywklvaYLGA4S5
	ahDQdAoibUhOVB3lvXV3ko2ZITBOq5Ji/fa1LQjyfPDTlhJVvkB7Cg1Z6mTxWcbpOMidjsqOop8
	TBHddRMj+DiCA5QAi3XA8CaVvl1x07YpBcTgQCz/ItvBBE3VTIj8mXXhp7c06SUZHO9/HBrKID2
	XDYgGahBZ1NBZQlqAD1N4cTcPvNcnmcdFFRHJeV9zxUfocGsSqYgW2ybyDCNqAK0TWrNld7F8q8
	PN0aE2xl/4Tm4+3593fhN1IhCjAf4syy36LJGlnvQa0VbgqB4JUQMqHIBYSny3U+mx/11r2CQAb
	oIS+FObaO1k7anFthtBzS6MynoMGFmSnkTIdMCU4sk+78McXBISakMdPI4w+vuniUlPf65wjP0G
	4=
X-Google-Smtp-Source: AGHT+IEFnoJ47e7b8X7FUCgUXJFp+M6HEk8QQku8r2B40eiA6Wxiefxrlh1a4+99394BsiieDEPFQw==
X-Received: by 2002:a05:6602:2cc6:b0:896:fcb5:4ba3 with SMTP id ca18e2360f4ac-8e1c4800940mr291928639f.4.1758598150200;
        Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3cdasm503126939f.4.2025.09.22.20.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:29:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:29:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
Message-ID: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> This patchset adds CXL Protocol Error handling for CXL Ports and updates CXL
> Endpoints (EP) handling. Previous versions of this series can be found here:
> https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman@amd.com/
>

I know there's still some in-flight work, but for the series so far:

Tested-by: Gregory Price <gourry@gourry.net>

Please ping me if major logical rework gets done and i'll roll through it again.

