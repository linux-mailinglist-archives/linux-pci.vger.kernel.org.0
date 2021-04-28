Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5741036D238
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhD1Gc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 02:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1GcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 02:32:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416DC06175F
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 23:31:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n2so8557686wrm.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7SDMaC9XvR83tRRodvSiYPiz4SET1TDhhehTgcHEZd4=;
        b=j/a9UBH3t0i5hrLc5an7n6VP9/wKyQJCzLVlhJhmCUzCPZX0IxWSOyX8/vtX5HoUJe
         ruZWRFBZKlM5ScAfl2p8gcDEYSs4Hh/KfJDME6FXdiy0n/HhNf4tlVB+weQoG/FWoBbR
         8QbWKrab3LkiePTGaKbhFX9U5uAvnhmJC5Qeo+uybjehMc7cK7tL9TkbQgeVtWawYD0l
         L77QsXULwS4nMzlgZqu0E/DPs7rlgT9wGSxX6qKuWp1o4q3X16VJS55cfVXlqqJVVgoi
         8Ix2xAiKD2/z3E0l/TZjiUyKzQOyg+WJm2qMUAHtFqKNCpq/FL/5W29EGCe1qirA+MNh
         3Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7SDMaC9XvR83tRRodvSiYPiz4SET1TDhhehTgcHEZd4=;
        b=eJR815ZhEFhdyjtMzxb+p8+jo3tDXD2Yk7wfPXIjOIWGzL+drir/DlmLY5mKV9tB3x
         D1Gheh4BMNuiBfdHo/27CTWKLssdtWVSDaKiTaOfCB664To3Nu0VqcsJQAe5QovgSiGb
         DfnMtZM6RHh7gLqRR7UHI+JvqstO4mJre6Mzgffr+vTwYkVxrCAmgPfaaQglwQBoRHy/
         D22UVA5rYQ3u1t4RpEXiHuFk4ORPCYT7wsD25Fsnre5JWMNC9OLEmH4kTaLoSBoWPu1z
         24QsXGePcbrRFaw/ka06H3Z+IJ20+IhJRmAgxCfepax4SlutRxoMGpR38ztpSIAg8Fbn
         I9KQ==
X-Gm-Message-State: AOAM532SNBofVQP0R+b8womBuiU2pn4LXVJHItntOaOoSIsOQFEmGmlw
        Sdshx33HezfY9mackFpEoR8=
X-Google-Smtp-Source: ABdhPJwhPLG/+63td455dPL2+Te97Ih1Ce+TYQl/qKlP0bICyo1O89y9M1Ax1A8it3bTJded+be0Dw==
X-Received: by 2002:adf:e783:: with SMTP id n3mr6414495wrm.154.1619591496161;
        Tue, 27 Apr 2021 23:31:36 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:d5ac:19ba:952b:8e67? (p200300ea8f384600d5ac19ba952b8e67.dip0.t-ipconnect.de. [2003:ea:8f38:4600:d5ac:19ba:952b:8e67])
        by smtp.googlemail.com with ESMTPSA id l14sm7026204wrv.94.2021.04.27.23.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 23:31:35 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Conflicting commits changing VPD sysfs attribute to static
Message-ID: <96350860-b9d2-b278-860a-a0e886723b3a@gmail.com>
Date:   Wed, 28 Apr 2021 08:31:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

85725825c10a ("PCI/sysfs: Convert "vpd" to static attribute") duplicates
what 1e3b0fb5e4d1 ("PCI/VPD: Convert sysfs file to static attribute") did
already. So this will conflict once you merge pci/sysfs.
