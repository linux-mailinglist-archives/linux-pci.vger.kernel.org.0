Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5C8A8F9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfHLVHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 17:07:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38744 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLVHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 17:07:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so844456wmm.3;
        Mon, 12 Aug 2019 14:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWOFH+vnQ/d55qFCAGVCq+EnpKRZ2n+KSZvDsQ6ulNI=;
        b=FIGNzvn5pMOFb/ZhIonIJ50VtezyxDgcWTRYehOfbeKYUPxQDhbs+0hCyixcoDVOBJ
         5Qz4ZQ5t/8nPfP7eyfeXzs/DpV0rA98IONqKnYAVh2YaOg0aNtFoA9iN4SPDoKLU0xSh
         cxKDTwNdP7NXa5nJcL0jLtzNXJP5KVndy6Y8k8SB+47h85zXpESwManC4CSAi0vLKKBH
         m2ZkOTv5c4c/kzywS4oVQ3hg80sHCtwcHVMbwoYEKJpLT07iPgd77/ZGj4pbqhX3Gzop
         gxeRf0sWVukmjnFyVzsUCNtuvLPWksP7cB5miInTq6yv9GjzlEgaQjt1HsClWNkWh114
         twfg==
X-Gm-Message-State: APjAAAUMDXvITrdZqQC6ZpaE3SfIhU6h88GP4ZYQETSrBxNTX/Tgw09i
        buwDFvmsdqa6ZK601QBWCQ+B8Qyib10=
X-Google-Smtp-Source: APXvYqyTfyfmXcBwUnQMX1BXqa6qMWfoGfpurBy5nZQqS3EqusXypmdFF0r/5bJNxz/6uyXyzPWj1A==
X-Received: by 2002:a1c:ed06:: with SMTP id l6mr1035718wmh.128.1565644018345;
        Mon, 12 Aug 2019 14:06:58 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id j9sm3380620wrx.66.2019.08.12.14.06.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 14:06:57 -0700 (PDT)
Subject: Re: [PATCH 2/7] s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811150802.2418-1-efremov@linux.com>
 <20190811150802.2418-3-efremov@linux.com> <20190812200201.GC11785@google.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <a23079db-e130-e3b5-deee-ff7c06d9191e@linux.com>
Date:   Tue, 13 Aug 2019 00:06:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812200201.GC11785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> 
> There's a loop just below here that should be rewritten in the typical
> style:
> 
>         i = PCI_IOV_RESOURCES;
>         for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
>                 len = pci_resource_len(pdev, i);
> 
> Again, not strictly related to this patch, but probably trivial enough
> to do in the same patch.
> 

I think it's already fixed in a separate patch https://lkml.org/lkml/2019/8/6/694
Thanks for the review, I will send v2.

Denis
