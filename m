Return-Path: <linux-pci+bounces-12806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B161196CF80
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F478288DFD
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F318BC31;
	Thu,  5 Sep 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zB3S4GhU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6013612D
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518355; cv=none; b=K1xcibXOQK46ieFBNP1RH7gUjinRUvtOLa0cngH2sQ0w+PAPAaSEaM/EYA3pvQD0RFPsRzfSf5iHjUJp3lTT4QfuO9FRkWrlJU8ap124PVBMasz16mdLt8rya8gzmW3kFkKe5Yo7GvEb5bC9J9IZSjnwNTuzKZ5JSIRPWtTcZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518355; c=relaxed/simple;
	bh=L14B7TmmibpVfx2cnKpjdQaOp4V40roDKsv1uyqCRQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SQbEzbwR+V6oLwVj467GdMnMgkoB2hwR6J67DgzJTpqrhZ9VclHMA7HqpCLyMlxdMtp7cGX79+VB40DdlmWHOSyQ2g6iGoClOcuNLzBf1PmZq/DVU94JqW2sH0UN9qBfOdKotXJEd5mJJLmMbQEH0LxoASr/rnWybDRoyxX3JR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zB3S4GhU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c962e5adso184437f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725518352; x=1726123152; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNyVczUVaf2j5tQu7mobJPe/DrDszvdX5yYxhDyxmfQ=;
        b=zB3S4GhUx/o7NzwxENenUR8NeEfGV9cjteFqRNW+BGfiKvboG5YycctAPqrTCe6IPS
         5YvT1tK0LBlWAvRzluC4fCN5axrKdJ6Siyum8T5QWonUmWaGeRm27Rzi6lVWLG6gE/jg
         0Xq6qYGAIrye8Ty/zHFyMA/7PqngFiycuCHxX5ODOn1nOdhhegGyi/1c1YnPsIcRjV/j
         OiYEmWtDb0EUcAmYEf4CqqaNTglU2lSQopPD6o/mKlmV0Z7Yvb/0SI7ls21ssNteHMxM
         3nFdvpg+oP5Pz9DEqB4BOkyqkLOlffoQAoYiuFdsiAxpWOZ3Rqww2KT2acpJZeXGnpgy
         fwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725518352; x=1726123152;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNyVczUVaf2j5tQu7mobJPe/DrDszvdX5yYxhDyxmfQ=;
        b=DDCf1dAahG3VKvQfUV+hRLvzFnUhR3Hoi632B2ubv2AUq8rbVZM54DVyb2xK0t4bYZ
         O3D4LY3tQV3UmoWXgsYaiegQ+yWZc1ZpmtUNSQ2JNvnhC5mwirp06V4ZlA7yS2PinYuR
         GbQ5BzQuSk6PNBalh3qFAkvNpI9PmOiUG+itiUhK6d6iUEze3KN4RusbxuGmc1G281jd
         suEZBtlopTTuqMmTaWzY1B0IkDarHSjG/kBsv1NLOn6sa/AlaQoVyEnc8BhpiMgo3cx3
         /YCZQQzc9SIjSoV9dDoTDxeo1zhugZSD0kElIVBI/zzwHmj3NW7wNmcZxLRtqpHa5LSq
         WRQw==
X-Gm-Message-State: AOJu0YynbdDeQI+oguAfwjhS99MO8dRJhv4dqVEtTYVlnBTN4OiPXgA2
	fR6HuWUA8M3vd8EViAEPxU2TPEFScSEDgHiepCPjiP+48MMar2+H5yqPAaZoWrY=
X-Google-Smtp-Source: AGHT+IEU/Z/f0fntXF87MWQmsZmCMKcPuYSwuSduSjS1TWSRgrHdM1AFzE6I8bk68N6cy78cBBrx+g==
X-Received: by 2002:a5d:4288:0:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-3779b847ba0mr2697567f8f.21.1725518352286;
        Wed, 04 Sep 2024 23:39:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df1066sm222759535e9.18.2024.09.04.23.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 23:39:11 -0700 (PDT)
Date: Thu, 5 Sep 2024 09:39:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [bug report] PCI: endpoint: Assign PCI domain number for endpoint
 controllers
Message-ID: <c0c40ddb-bf64-4b22-9dd1-8dbb18aa2813@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Manivannan Sadhasivam,

Commit 0328947c5032 ("PCI: endpoint: Assign PCI domain number for
endpoint controllers") from Aug 28, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/pci/endpoint/pci-epc-core.c:843 pci_epc_destroy()
	error: NULL dereference inside function 'pci_bus_release_domain_nr((0), &epc->dev)()'

drivers/pci/endpoint/pci-epc-core.c
    833  * @epc: the EPC device that has to be destroyed
    834  *
    835  * Invoke to destroy the PCI EPC device
    836  */
    837 void pci_epc_destroy(struct pci_epc *epc)
    838 {
    839         pci_ep_cfs_remove_epc_group(epc->group);
    840         device_unregister(&epc->dev);
    841 
    842 #ifdef CONFIG_PCI_DOMAINS_GENERIC
--> 843         pci_bus_release_domain_nr(NULL, &epc->dev);
                                          ^^^^
Passing a NULL "bus" pointer doesn't make sense.  If acpi is disabled then it
won't do anything, but otherwise it will Oops.

    844 #endif
    845 }

regards,
dan carpenter

