Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98E46A8DF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbhLFVA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 16:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349909AbhLFVA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 16:00:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBEC061746;
        Mon,  6 Dec 2021 12:56:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so48289860edx.2;
        Mon, 06 Dec 2021 12:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=zW57z/mHfDhkYIG5+O+nmTT3HcS8kaxpmLSDbRZdY6E=;
        b=YEbQAIB6/2RNsMnrpsGeD/5kldym/jVHFX7O1XZ2R9BNaDudxi4S4NBT/27l6ajbi/
         W3jIOvR/6h6eTVbkQ4wS6dCfV6juGR7Q3tNub6y301MwGqgEv0OdWES7G8VKxiQLIeUT
         N6bucMA31ULwBX34K3V36MHDQn0E3HPbvS0kWNjnmX8N9Yp6+jJFbbO8xXOiEuJXWzKr
         dUF6floksETsEf14c6cRQFIR4XpNFE1l044vtEqFpNYWSAjQov4tYfnw2dkVA87zUPdX
         NLVfuwlyYHdNIOcDcH11XDm2MdsYFJSg6kXd+hEfOx7eUtJ6LqMvjaLyU7EaQI8PbiGe
         TBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=zW57z/mHfDhkYIG5+O+nmTT3HcS8kaxpmLSDbRZdY6E=;
        b=4C2qX+TnSOVMEc6ycnsV2ZapSXjn9qUc88fisi7QCBS9qoKw3xAZMBOzalWaL1xzbB
         C6txmnygJ2mAKbo2xljAmQkoTArBcFjpL0mEUt5ZaitHwXgV8QBH4sfSQOzgyY0z5v3f
         kn3QUXloiSmn7rcgG0W9aqOyOgRg1xUC2H7Wfcq0I38pTXDXUNSZRyAu64VMsIDkKhSE
         vk+RL3xjv0a31A1J1oCq/1keXhB73/BzMbiWHhPvDMuA2Tm6aXmPx5VwMSCZu92zQ4Gd
         lP0TMmTY7zJUg2dib4kqLRd1q/z5I/UvYdE6uvflaoVPpa9R/Y4MF//gI4E33EJE5hTO
         zewg==
X-Gm-Message-State: AOAM533TZI3ickqupH/LHNd1kLfEs8OenMmgNOce3St5SZO5/Ow31Ja+
        IZdd1F6qWS1YiBnah2oqgAgjnzUBWAk=
X-Google-Smtp-Source: ABdhPJxnQc3AE2ashfXONSe9zNZIei4vvCtnrAVEdnK4+I99PfBKCjK6qbuKhNsv7P75nemmzLjl5A==
X-Received: by 2002:a17:907:961d:: with SMTP id gb29mr47749086ejc.102.1638824216012;
        Mon, 06 Dec 2021 12:56:56 -0800 (PST)
Received: from ?IPV6:2001:981:6fec:1:4191:929:8d49:102e? ([2001:981:6fec:1:4191:929:8d49:102e])
        by smtp.gmail.com with ESMTPSA id h10sm8703987edj.1.2021.12.06.12.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 12:56:55 -0800 (PST)
Message-ID: <a19ca757-195d-c2d3-c1b8-529c1028a37f@gmail.com>
Date:   Mon, 6 Dec 2021 21:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Ferry Toth <fntoth@gmail.com>
Subject: resource sanity check, mapping multiple BARs
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Between v5.15 and v5.16-rc the following (unrelated?) errors are 
appearing in kernel.log:

resource sanity check: requesting [mem 0xff200000-0xff3fffff], which 
spans more than 0000:00:0e.0 [mem 0xff298000-0xff29bfff]
caller devm_ioremap+0x45/0x80 mapping multiple BARs
pmd_set_huge: Cannot satisfy [mem 0x05e00000-0x06000000] with a 
huge-page mapping due to MTRR override.

This is on Intel Edison (Merrifield), which has (from lspci):

00:0e.0 System peripheral: Intel Corporation Device 119b (rev 01)
     Flags: fast devsel, IRQ 25
     Memory at ff298000 (32-bit, non-prefetchable) [size=16K]
     Memory at ff2a2000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [b0] Power Management version 3
     Capabilities: [b8] Vendor Specific Information: Len=08 <?>
     Capabilities: [c0] PCI-X non-bridge device
     Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0 
Len=024 <?>

Any suggestions on the cause of this would be welcome.

Ferry


