Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774EC9FFF3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1KcF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 06:32:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1KcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 06:32:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so2279259wme.2;
        Wed, 28 Aug 2019 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=O9bYm+nsJ9IvBpQO/QVMQi2zV67cEqyaEMQRFcxhnAU=;
        b=KDEmsUc7HCO4dnB3WwF+eR0XWJULy/HSWbfq6Tzib2PecM+pX4J6XeWbdR6mjPog9b
         Ivvpck44TaTTQ88e6kzk5BIzV3aGTcfV+jHkRIACnbsSGdhJJYpNE4fUoBV7JmTYJH/x
         3PuFcT9XKiY2PT9bZWU9YXuLac7a6zw2ek+r21S0ag7wljteE2tfDlsrDhgBrCtjo/TF
         qxtkftZKlHDSTtpSfO20GNCGMaIuNktI2tIE5uaDf0vnbWYedZKz+hptfGASywIY/2Xx
         1SgwzHnJP6NG0CjrG88b8xJLV3Qm7RR2aJ8tzXybOVx2m1nfoJaCv9OelAixySM29TFg
         8jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=O9bYm+nsJ9IvBpQO/QVMQi2zV67cEqyaEMQRFcxhnAU=;
        b=M0LEbs/4gMjjXK0/Zc5+R597cxzpQk3FyuvyoZPzchUs3vDPvmUZXowyl+bgPzRMpF
         yZCDhrvap5hDoZ1JN4AJuiEqRrQ2ubP/BzawhccnCWPkSqkIva8xUjOAWISSW/oQe9lN
         AAcxwYegsOo5/T6Zabhtu9CcYdl88IOM4iBUAsu0IsPoPbDm3bGxeWR0ajHxyCp2H0tR
         Bbi4yBTrdWTN19cyA4JcVP9Ns/Nyr70nHtP88445UDees4A1g+O6Jv3QU2eL6yB5XDRs
         GY1e+kW7Rh0e51FDzPrIRtRQ9JrZLIZfHg43VI71AP9O1vhNY5ZebCuv7FHshlOUevkN
         LW2g==
X-Gm-Message-State: APjAAAUTPQ2dYSXupWlMjGVv7Dah0dkPNWuaeqWmyG6Qh7QwTj7Aolcz
        7SXIBY7/ftEpyURX/3PtKQM=
X-Google-Smtp-Source: APXvYqyd0950RxmumVL/1HKXnIl5wEhYU7GYA8pBokTHKVTP81dK9Zni52g5XauBTsmBAWhtjDXIKw==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr3628820wml.87.1566988323034;
        Wed, 28 Aug 2019 03:32:03 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id g13sm2819125wrw.87.2019.08.28.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:32:02 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:32:00 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: Re: [PATCH] x86/PCI: Add missing SPDX license header.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1566988320.26704.1@gmail.com>
In-Reply-To: <20190827232457.GI9987@google.com>
References: <20190819060624.17305-1-kw@linux.com>
        <20190827232457.GI9987@google.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

Thank you for the feedback.

[...]
>>  +// SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * This file is subject to the terms and conditions of the GNU 
>> General Public
>>    * License.  See the file "COPYING" in the main directory of this 
>> archive
> 
> You can remove this license text at the same time as in 8cfab3cf63cf
> ("PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate").

Will do. I am going to send an updated v2 that takes care about this.

Krzysztof


