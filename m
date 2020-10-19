Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9186D2924C5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgJSJlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgJSJlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:41:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC240C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 02:41:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so2077925plq.13
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhO5QcYpf/T7mrG56Eevh6Ri2KFYtB0nK9sFJd8u9zY=;
        b=AgTQMJYJlH3kf3k1YpTj67FxysthUNAuduv/TaCvLEC/Wf+c6M1pXh7WTiVkrrmtfT
         ohrh4uEsK4cgw1f7WB2egQyVmGFquSFR1cKcCdgmUBsJyt30tXUiqEOzI1hMvMuDELnT
         T2/pzvJFCfMb8aFBrVOZodeDDYyx9H3nnelPtu2Yqa2kYAeIYPwkbIOqRS/85YfstoC3
         8Uob7JzfwVJXMwD6BI0T179/+EzZ94TG/i2XMrt4osEYHhKpxLg5GRtQ2EzL3+QsC6VH
         Id58yfYnx+/rspT6LW19e4dKDkSe2hpdt0yQbI38lMlPDWpErKx6+eHDSz9BA5Gy6JWF
         Z3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhO5QcYpf/T7mrG56Eevh6Ri2KFYtB0nK9sFJd8u9zY=;
        b=QPaPWh7ow3CdfdBVwmakpqGgVPboARiz3yHjD2cIrY4TUa4AazifP/oahOOpiqN8hq
         TYpIb7+eFF4IF5rzpAjvbzjdwrhsqEaG5BySUZpfb4W987UVBGLl7OTF7pobzbSKfS76
         Rl0R32Bhv9yMd0Pz5j0YY8l83y7bt/PL9IyUu/0mERspscvyNozyF8zBFwZRvEfsaW+B
         yhkceF/qXqdvWKYXtRtyhRVsNyOV+Hm5Far3dOr9ecc5Q1MQbdg6aBXga5tNSeQB6eII
         5o8ot8p0lZTEtP7U5aW6gTqro8BQ6J1i5pIb//q8pgF34OQwtEhxXyFMBc0gMu2caIEn
         5cyA==
X-Gm-Message-State: AOAM533oRhvy2tmWH1Cdl0juiJOhuRj116bAuWdfVHRX0hB+apiNUUh1
        u5eomCMxdguVHh113z/z2qW37Q==
X-Google-Smtp-Source: ABdhPJx94ex/WUriPHvU/TfgFAvh71TrzsvPFKogNma6pbeKUv/epKwKm67z+QkngUHHO4T9ih6/+w==
X-Received: by 2002:a17:902:6545:b029:d3:d1fc:ff28 with SMTP id d5-20020a1709026545b02900d3d1fcff28mr16486772pln.34.1603100478227;
        Mon, 19 Oct 2020 02:41:18 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id u2sm7253215pgf.63.2020.10.19.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 02:41:17 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Keith Busch <kbusch@kernel.org>, linux@endlessm.com,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Date:   Mon, 19 Oct 2020 17:37:35 +0800
Message-Id: <20201019093734.4091-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904171325.64959-1-jonathan.derrick@intel.com>
References: <20200904171325.64959-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>On 2020-09-05 01:13, Jon Derrick wrote:
>> Some platforms have an AHCI controller behind VMD. These platforms are
>> working correctly except for a case when the AHCI MSI is programmed with
>> VMD IRQ vector 0 (0xfee00000). When programmed with any other interrupt
>> (0xfeeNN000), the MSI is routed correctly and is handled by VMD. Placing
>> the AHCI MSI(s) in the fast-interrupt allow list solves the issue.
>> 
>> This also requires that VMD allocate more than one MSI/X vector and
>> changes the minimum MSI/X vectors allocated to two.
>> 
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>
> Verified two platforms with such configuration. Thank you.
>
> You-Sheng Yang

We have some laptops equipped with Tiger Lake chips and such configuration that
hit the same issue, too.  They all could be fixed by this patch.  Thank you

Tested-by: Jian-Hong Pan <jhp@endlessos.org>
