Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396432B6927
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKQP4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQP4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:56:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA0C0613CF
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 07:56:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 23so23654308wrc.8
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=DDCfmqxMENHjETYXvv/5+Z4ZTHuhvLOIXeEU3+XDkaw=;
        b=IKW/l9FynsJ3/qMPI1qvox5zbn/yFeCXrgM6wdnXQC881N0aJryK63RCWTfU9D/bIv
         VNmenYUviqu+52NwAZEZX7vkfX5khMT7a1tklJxJvCntwVUAUK65/+qaoZbQexoy7irV
         ZX96CgzkjbdyFL348DdRDStBouNhWWuNhGy3HVUL+egspe4kVlXXVxoJ20OiyCNeQ+97
         NpMYXPEYp0h6nGN6P7oksMzPPPih1axIhV29ljPFyBYk6O+7u4gACaSxSoSfHREIUKT7
         cFveSzz2JXDb7Ng4EVDSsm6kdYARywkP7CFMVFQuow/N/gVb9tkqghAfNMB7lV9xoAAO
         zeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=DDCfmqxMENHjETYXvv/5+Z4ZTHuhvLOIXeEU3+XDkaw=;
        b=AUnqLf1hXRaKZjB8B2grVbyX4asf8hOlF6QLlVGm1UQqVVOk8dGA2P9hDlgles6Rvu
         B44+XFFSqC9XhBxKJbdUfQY1mLavDCjHh6CXqzymnGtp0EwTYXKgWmolwiK+vKtTZhFn
         DMmEgYNqton57XGDaVokWE0go5YWcMjjBjySCrknQaAGba7fKzaGBGzoK+RbOP9bUYqb
         ztLBhF+eJKlY74iVZJ2kdvqT8UPEM9aCfmLfHMEgbIT6OQZ658K+ioKVOHyNy0gUcvrJ
         bYqrkkorYolwYz6dzDJJ8p8b35Q1WuCYeO9zBE7svTBAYiTq6t7NXaRKDRMK/fNPrNm6
         BHJw==
X-Gm-Message-State: AOAM531VZg5JRCw6t84KHLeioDI7diS0Oc8ekyuEYwjoPBw/rYWk1Pfd
        SkU59+czktpBu4CGUtvyYfWZPj5WP42/lA==
X-Google-Smtp-Source: ABdhPJx2JcB1YJJd6d8KmnTh64iXhTmBVHzNR+z7URdJgvNZqjtF7VE9YwbFRhZN2yHB6Kfimh8fvw==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr169395wrk.71.1605628577053;
        Tue, 17 Nov 2020 07:56:17 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:3907:f821:c784:61d9? (p200300ea8f2328003907f821c78461d9.dip0.t-ipconnect.de. [2003:ea:8f23:2800:3907:f821:c784:61d9])
        by smtp.googlemail.com with ESMTPSA id p4sm28578050wrm.51.2020.11.17.07.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 07:56:16 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Time to re-enable Runtime PM per default for PCI devcies?
Message-ID: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
Date:   Tue, 17 Nov 2020 16:56:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").

Reason given: "avoid breakage on systems where ACPI-based wake-up is
known to fail for some devices"
Unfortunately the commit message doesn't mention any affected  devices
or systems.

With Runtime PM disabled e.g. the PHY on network devices may remain
powered up even with no cable plugged in, affecting battery lifetime
on mobile devices. Currently we have to rely on the respective distro
or user to enable Runtime PM via sysfs (echo auto > power/control).
Some devices work around this restriction by calling pm_runtime_allow
in their probe routine, even though that's not recommended by
https://www.kernel.org/doc/Documentation/power/pci.txt

Disabling Runtime PM per default seems to be a big hammer, a quirk
for affected devices / systems may had been better. And we still
have the option to disable Runtime PM for selected devices via sysfs.

So, to cut a long story short: Wouldn't it be time to remove this
restriction?
