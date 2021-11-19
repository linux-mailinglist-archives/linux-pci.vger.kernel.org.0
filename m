Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AC456E00
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKSLNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSLNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 06:13:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92568C061574;
        Fri, 19 Nov 2021 03:10:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so7713233pjn.0;
        Fri, 19 Nov 2021 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6cWAmlDlAF59x4LqcOU/XShYfmYEgb4772Ge0zuawgQ=;
        b=ks3fFLzUFxnyfEU6VkMBuDy9Ur6tgo8k6gs9eRJyRE3XRvxt7oqPmCCzMczBDEwkJp
         Ob5J5llfw8vqiGruy+OC4KFtXmIY8MPOGGjHloaUXpgvry4nY3rWG1Hc90hPxMVbKPsw
         MRWEd+/O274lMNedkRjozFMLU1rYY8Nno+Zx+LIURGwVoqY/bkI1vHyayL2UQObs66CG
         rdrMebdPSoL1yHlMLmskAqoaZ4I4gz1UeibUqaP6wxlpzqqayzrBC7VZ0SzHE3hgHwbl
         4RQAaO59BcM8aJtyfSTD9DadiQQvikEkU3XfB6yW/Te3fbfxkYPO16dQ7cBk7+kF4mio
         J9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6cWAmlDlAF59x4LqcOU/XShYfmYEgb4772Ge0zuawgQ=;
        b=K/HaTuT9cZZwV0Ly+sRblNpN9HmyLuS/FxQIHyVhNAlwcO2JF4le4LimrIlCETL4Eu
         7mgclrYP7ya+R8U81y0TY+RJbs+CFVuolNyi4Dus6Fgb7wr34fDM8fnozPE6rhM0Nhiy
         fV45YGAZWU4OTiYXg1BI/GSfsJhiesD84bWtNprkn6147nhAqoogkir1LEOmNpUDK7IB
         RnnrNIogy4P2dU1c1EKb7YSBRlcrzIO7g7+7k2lPlbgSPiL4HkoEwlqID/HwXsR+NshG
         MfxZde+iI7JNuJFgai/8w+pg6JemyMvsFENM+IOuQmmfblnmJ0yMhE4RYwlfx1RT0mE2
         lY5A==
X-Gm-Message-State: AOAM531KyC8Ndk7Qo+E5AWqn0e+7Rla4FBXoAQZcpont0r+7vpv45gZh
        bb0SQENZZmj4QUcWqJpdmHOmTLwV41Rc5NBm
X-Google-Smtp-Source: ABdhPJxV+Pk1GPCfZmTWufJoVNVs22CQ7LdNAReT9GuuuFE4f7nR5BbG9XzKTJpNj27B+JUr9T7PzA==
X-Received: by 2002:a17:902:bd88:b0:143:d318:76e6 with SMTP id q8-20020a170902bd8800b00143d31876e6mr33099354pls.66.1637320218081;
        Fri, 19 Nov 2021 03:10:18 -0800 (PST)
Received: from theprophet ([2406:7400:63:2c47:da89:58f9:fd04:7bf9])
        by smtp.gmail.com with ESMTPSA id z19sm2522822pfe.181.2021.11.19.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:10:17 -0800 (PST)
Date:   Fri, 19 Nov 2021 16:40:07 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 1/1] PCI: Add KUnit tests for __pci_read_base()
Message-ID: <20211119111007.ihxnziwbwo7u4wzx@theprophet>
References: <cover.1637319848.git.naveennaidu479@gmail.com>
 <a049a89cc673492d12415ebd5195a2b50c2b5626.1637319848.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a049a89cc673492d12415ebd5195a2b50c2b5626.1637319848.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greg, I added you to the CC list, because you left comments on the v3 [1]
of the patch. Apologies if that was not the case and sorry for the noise
^^'.

Thanks,
Naveen

[1]:
https://lore.kernel.org/linux-pci/cover.1637250854.git.naveennaidu479@gmail.com/T/#m0e0231f1dd9a70bc127736d436aefe79c9838115
