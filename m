Return-Path: <linux-pci+bounces-6350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF798A8362
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749A4282CD3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087367FBB2;
	Wed, 17 Apr 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8IAMO67"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C513D2A9
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358076; cv=none; b=Q/9unsu+ZqNT8ojGQfGYnxxeaVsFuFgHSCIdFbQJ5VhDx4qbaXQyyRZb0F8VBq86n6ARlVgTIyohYBjbFikhOPaAnYbNY09vvLeyVZKfzagizpy2deMdQfYh4koZQmdmK7heTBRU3Of99//WrxZTs2wX3QayuOd3lAvjlOyoipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358076; c=relaxed/simple;
	bh=ep5cX8OlayhAaKf5zf209N+YUW2ztx++meOZEl9TjMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fONqGsbRqHgss3cpPxuxGTYdf7mZEFLpJrtujFj8nEOl4NwaFUNfvSvLUHLStKza2tGe8QqUSv3NZGOiVK0B2wtDJ4nsrY+lvUtJmL6BCgdo7sOChUBosKUxLj03TM0YXPCJbagUUQS1UsxmU/y5pEkt5avCBPTi2wR817YARJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8IAMO67; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5224dfa9adso142317166b.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713358073; x=1713962873; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCXYznk3Vu7v1npDRGP0z9D6H0IgazHfbfz2LB2HYQg=;
        b=B8IAMO67LZ9D3PqHoocuvaLf48q6xkI5xxDjIFerCJrJBrHTaQ0SUVl0p72c+Ezi9c
         R5jXVHedfO8oNIaz0JvZna3GneE4k5WMh/PXscw9WczM+MU0qFB1POo5rl75qGo3J11D
         PiAmEoEDPUgjg9XNu9q4FSlkbfAWRS3pRGIrKA0qmxAIvwnhOJQ7msNjw+x7tIXKmv4w
         SMuLEA8WSbMAkcjPQx8mn9tsccQxI5jjQWli0rTGztUkXTlzPCdu3I+m46bPj0zUE2BR
         xHRdTncJ9CfpOYQviG1E95B0eKc+c4TVHj8edSVflfolA3Pb7yg2Z23MaN12u9tJaoY/
         WsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358073; x=1713962873;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCXYznk3Vu7v1npDRGP0z9D6H0IgazHfbfz2LB2HYQg=;
        b=ex6MyPOS9dcj0BuH7qUaxggUs3kJ9rrBj/j/W0C6YY8oQMUrdDKg4twWypOjSQPwkM
         e2Ika7nOte2kDZkEUp+PNGh0oXfj7z9k8Op/Id6LybWVm0TwLydQIUG6hqO8lPWXln8K
         R0YhjLT3qNJs6CEffG0UoYvcvBV6LMEqCihhdWTwsJeLd9uEnsPoQzd6KEjMmjskVs7R
         RuDGWPW2TiaPtldHy6mjwVGjb2XNcwRPYR+qJiN5PehPFJMXNZFPkUtuUIDZSYjCwBdf
         v5+0x0kZdg3LjmL2od59hOLy+PzFcnWhgak0Z6kH3UIGAjDZo66BpTEE0uGzylJ71o9Q
         D4DQ==
X-Gm-Message-State: AOJu0YytBcvpeNKPnC/Xa2c4KScubwtp8I1B4VCuXZ1vS1D8NOTdHa9X
	bGLA57smwVV0KX1shsK2DMR+0U65V8JdBF9LQxnU9Amcq56NdJa5Ak8x41/SULk=
X-Google-Smtp-Source: AGHT+IH0OUOLBJq8ezXsz4lVrplaXfSwza9PRLLwGXEW741F2hlEPbspWR+IwkVPORNi4obqf7umOw==
X-Received: by 2002:a17:906:f196:b0:a51:c62f:3c91 with SMTP id gs22-20020a170906f19600b00a51c62f3c91mr4960302ejb.21.1713358073253;
        Wed, 17 Apr 2024 05:47:53 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qw17-20020a1709066a1100b00a473774b027sm8048666ejc.207.2024.04.17.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:47:52 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:47:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org
Subject: [bug report] PCI: endpoint: Remove "core_init_notifier" flag
Message-ID: <024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Manivannan Sadhasivam,

Commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
flag") from Mar 27, 2024 (linux-next), leads to the following Smatch
static checker warning:

	drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
	error: we previously assumed 'epc_features' could be null (see line 747)

drivers/pci/endpoint/functions/pci-epf-test.c
    734 static int pci_epf_test_core_init(struct pci_epf *epf)
    735 {
    736         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
    737         struct pci_epf_header *header = epf->header;
    738         const struct pci_epc_features *epc_features;
    739         struct pci_epc *epc = epf->epc;
    740         struct device *dev = &epf->dev;
    741         bool linkup_notifier = false;
    742         bool msix_capable = false;
    743         bool msi_capable = true;
    744         int ret;
    745 
    746         epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
    747         if (epc_features) {
                    ^^^^^^^^^^^^
epc_features can be NULL

    748                 msix_capable = epc_features->msix_capable;
    749                 msi_capable = epc_features->msi_capable;
    750         }
    751 
    752         if (epf->vfunc_no <= 1) {
    753                 ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
    754                 if (ret) {
    755                         dev_err(dev, "Configuration header write failed\n");
    756                         return ret;
    757                 }
    758         }
    759 
    760         ret = pci_epf_test_set_bar(epf);
    761         if (ret)
    762                 return ret;
    763 
    764         if (msi_capable) {
    765                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
    766                                       epf->msi_interrupts);
    767                 if (ret) {
    768                         dev_err(dev, "MSI configuration failed\n");
    769                         return ret;
    770                 }
    771         }
    772 
    773         if (msix_capable) {
    774                 ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
    775                                        epf->msix_interrupts,
    776                                        epf_test->test_reg_bar,
    777                                        epf_test->msix_table_offset);
    778                 if (ret) {
    779                         dev_err(dev, "MSI-X configuration failed\n");
    780                         return ret;
    781                 }
    782         }
    783 
--> 784         linkup_notifier = epc_features->linkup_notifier;
                                  ^^^^^^^^^^^^^^
Unchecked dereference.

    785         if (!linkup_notifier)
    786                 queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
    787 
    788         return 0;
    789 }

regards,
dan carpenter

