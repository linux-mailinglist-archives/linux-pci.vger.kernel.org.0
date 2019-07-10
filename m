Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB526419D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfGJHAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 03:00:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJHAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 03:00:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so627189pfe.6
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2019 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=+XMCtJ3hGSoSPbe4vQH6ljzXmpF0ulGFVVPRCzw3C8A=;
        b=F1BD3RfKhRzBKTO8iAVmDvOQtWj88Av6mWLCgOaNeOULt1OioS4O0BiU3V7iDg9psF
         ct6I2hgM5bZPozL2/tL3tXaUwwoo8jXqsKWaYxQk35tSkzangLuOq+glwyUVILs9mKTH
         lpGVTa1WvkaOlcAAuqJcAjW5RB5rweeTGdEl8dFIO/crUS3Nmdn2BVMc43b+gC1Y+/NY
         QdOUGdSZc3qrNU741QpzEOpzYhgluR/w/pEqSoiJBcLQC3IKGRiH47HNdi7l5JLOG50z
         qenWzrD7Eo/djLgrTSGioemIHN+nSdXVKt1Bl326KHpNBPmT802IsNyGTl/l1QPIENoL
         hHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=+XMCtJ3hGSoSPbe4vQH6ljzXmpF0ulGFVVPRCzw3C8A=;
        b=bdd32WBsouomnYs+bHNuaQz1a3e9s563u1yY4D0lddgHg0UJcOm0aErANnk4+17IQY
         KfHBDvjQ67TmD2Gd95FctM1jFMLO2vaBP7APRwdTXGyjFsHHRpoB0WuOiz52UuyFOGMB
         oEkTQdEgpJ1/isAFbKfIDnXsFpE/pejKE5+GoqekJ5NEfXDg8ls5hdj/WUFaAeJNlwuO
         p6ptiepgp8fBsiWDW/XIWwKwDX1Nl5fTRLIbkJ+OzX/zFp1xcMl0BPTRB7vOA/04ELiF
         mX50hZDQWp3bwsxS9nprxoq4HF6Kc0dO/glfUfRbnPX3eITBMB62Dq2lTJk3chaPdG3e
         0fBg==
X-Gm-Message-State: APjAAAU4EFEWIare5QmfgruaJEl0swN7rvb4lAJO1/Skp95WMnPCxKrz
        LPnjGc1uIM1Bc+CGZr42IWTRNNKz/Uw=
X-Google-Smtp-Source: APXvYqxJnOSkqm2Gd2O759rs9Be/ljq/l3W4bbHgO2R4TFp6P/Ku47fckwuDw9E67p2XrkuipzCexg==
X-Received: by 2002:a63:194f:: with SMTP id 15mr14610505pgz.382.1562742001231;
        Wed, 10 Jul 2019 00:00:01 -0700 (PDT)
Received: from localhost (114-32-69-186.HINET-IP.hinet.net. [114.32.69.186])
        by smtp.gmail.com with ESMTPSA id u2sm1013619pgo.92.2019.07.09.23.59.59
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 00:00:00 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
Date:   Wed, 10 Jul 2019 14:59:57 +0800
Message-Id: <20190710065957.27899-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These patches work as expected and provide an interface to toggle PCI ASPM
link state, that's really helpful for PCI devices to check its ASPM
functionality by enabling/disabling it runtime.

Tested-by: AceLan Kao <acelan.kao@canonical.com>
