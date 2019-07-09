Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB763688
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGINK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 09:10:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGINK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 09:10:58 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hkptX-0008Oi-Ue
        for linux-pci@vger.kernel.org; Tue, 09 Jul 2019 13:10:56 +0000
Received: by mail-pf1-f200.google.com with SMTP id 145so12401866pfv.18
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2019 06:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Dle3R/JKkJuvARNfD4j2spSdPlYkaOQ8jZ6z5Qf88A0=;
        b=d3zxg6JpR6i8Idql2TuhVMutJGluP/B77wpj0FAglKA+0g0uLu3+AnlOsvMZDYfIum
         rqyWUZcDtWXSiDnDXHtvczgjP7EtdREQTq72KfrpL0Ju4n3SS3QCkFc0tbZb6jVPHG7x
         VGfWdNQFuPkgx/VyIbc+YrY72rPORfijSGsp4Kg9X2RPZQIIOQ6OUkdVijpxAzi9DOte
         LEwYJ4ih7j/mcG8tYvipa8fKk5DAfLn8Ug0r+T0CY9PNr3tyk+8ZHYUt+tC2hV+EJ6jl
         FI9cQQafxShY3DA5tVWvcNV0JF6HAyVfaF/5tp+0tTxKF9vrdjDjjPPi1YXj8a9YyHgI
         wakQ==
X-Gm-Message-State: APjAAAXFNTrtt7RTtmef9CbpHXWwNz8rALJgZ2maW0R7KHlKSHYL5xqE
        3CHLYHkWWcJjXDrILKa9bMt3GIVOiMeAfY12faXNulz9q4+zgqYY+Y+zycOFEQcJmaHciWWWjek
        zJKD6bps1YTaUOMGplKt73bLymfq+5OxYGys0Dw==
X-Received: by 2002:a63:f817:: with SMTP id n23mr30760732pgh.35.1562677854631;
        Tue, 09 Jul 2019 06:10:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+JscG/oIDZCvSNZ9ftS2I2PR2LBnqUfsgLH98941/ARkm1AxzCpb81QGpks1mOId7EfZqYQ==
X-Received: by 2002:a63:f817:: with SMTP id n23mr30760689pgh.35.1562677854293;
        Tue, 09 Jul 2019 06:10:54 -0700 (PDT)
Received: from 2001-b011-380f-3c20-5cef-9a28-6766-fbdf.dynamic-ip6.hinet.net (2001-b011-380f-3c20-5cef-9a28-6766-fbdf.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:5cef:9a28:6766:fbdf])
        by smtp.gmail.com with ESMTPSA id j15sm1366492pfe.3.2019.07.09.06.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 06:10:50 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Titan Ridge xHCI may stop to working after re-plugging the dock
Message-Id: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
Date:   Tue, 9 Jul 2019 21:10:47 +0800
Cc:     Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika and Mathias,

I’ve filed a bug [1] which renders docking station unusable.

I am not sure it's a bug in PCI, Thunderbolt or xHCI so raise the issue to  
you both.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=203885

Kai-Heng
