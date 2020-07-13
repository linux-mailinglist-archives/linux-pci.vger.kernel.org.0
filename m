Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5121DE4A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgGMRQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGMRQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 13:16:24 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8DC061755;
        Mon, 13 Jul 2020 10:16:24 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a21so10075835otq.8;
        Mon, 13 Jul 2020 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zyBbRluQ5lYnUX7KFT5ZGZlRL0DFuI68QfOqM4RCzdA=;
        b=gFu1qFbDmtup0YSpFIfNaHM0a48eh0Ul1xSKNTnWGxWxCcBWiJ9n6R78PekE3f8A7p
         JtyBKwiVNIPBHsm1iLpcnuAI0d7JLvtXpcO2cPmP2Y/1z2LNW8bn0o3s7tgh3ZFU6b2s
         rYAWZryk+LgjPlE7o2+DXW7bCV12FqJAwCESb5liZr9Gxj0/Tl4/+tGlQjUz/iqYICFF
         R+RprQ6Xn5hWYnV3XgizYrw5LtuKlYa2H3jLOaZr2I4xgAgwckrkDkpSTcemOFp085ki
         yPBScHeFWTT5WT96kmmb5qlPZuhyRlVOk8bHWSEAQe+f2EQyzg9XgzSPG+7m3XzozbWW
         OJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zyBbRluQ5lYnUX7KFT5ZGZlRL0DFuI68QfOqM4RCzdA=;
        b=c+D7xGPGxS3L5Lknb+0Xz6Kfz9L1JK9hhxvgMxkg6vHrsdamLMwiEUwNzwg3Zv2P8h
         XgK3tLlgDASQMgp55YHX4kS7CDjZ4/KFLRV8LQieaycZzq9OLwzjzABjcC5DlQWChrp6
         llrXAENAzeqxw+4hyzemobUq5JHgtNj+yzt+PKviXFGZdUcqvR25TEk8fr/vRle8R/ol
         ge7Uiq78VQ9ug9k/J5rw/boQNKYpOexKnqF10ilXcCBwhvnFUKKGB81WeVe3/5VPcAe/
         W7OqYtZSt+a4a7p7Wae4Rq47WJiAlm/U+D1Z6yqc00a09FAd/EyvNZxBX7v3h0oV99fj
         pjHA==
X-Gm-Message-State: AOAM5328Cx84uwL0oUNjoPBMTCMeFMBk0RtF0qy4tBU3pRMpqV25oohP
        ONa9yOt+A4WNWPDk+hKGcx0yCn2c
X-Google-Smtp-Source: ABdhPJzJONrB+kPTWhVu9FhPTJ3Uhjr1/qB3HON7hdP7A8eAITLGJ3+s1k4xTNEcxUfwaaXa3lhIsg==
X-Received: by 2002:a9d:7a4c:: with SMTP id z12mr595958otm.126.1594660583279;
        Mon, 13 Jul 2020 10:16:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a16sm2824303oid.14.2020.07.13.10.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:16:22 -0700 (PDT)
Subject: Re: [RFC PATCH 02/35] ssb: Change PCIBIOS_SUCCESSFUL to 0
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        helgaas@kernel.org, Michael Buesch <m@bues.ch>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-3-refactormyself@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <70e57af0-6a8c-a893-67c9-0181af16ae2b@lwfinger.net>
Date:   Mon, 13 Jul 2020 12:16:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713122247.10985-3-refactormyself@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/20 7:22 AM, Saheed O. Bolarinwa wrote:
> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
> Their scope should be limited within arch/x86.
> 
> Change all PCIBIOS_SUCCESSFUL to 0
> 
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Could you please tell me what difference this makes? It looks like source churn 
rather than a substantive change. The symbol is defined in pci.h and is used in 
many architures. Certainly, PCIBIOS_SUCCESSFUL indicates success even more 
clearly than 0 does.

Why is your name inside quotes in your s-o-b?

Larry
