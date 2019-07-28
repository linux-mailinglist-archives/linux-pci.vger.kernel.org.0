Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23515781B2
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfG1VR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 17:17:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35216 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfG1VR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 17:17:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so40582464lfa.2;
        Sun, 28 Jul 2019 14:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tN8YL2pQyrABeKZIVp057A9v5AQtBoANbzQFMqyPC34=;
        b=XHQuqOIYFXElLhOavdpekHU5o4BYYOhWFGHDpaofT1syGrehv7lgFt+UR8+1kn2C84
         qvY54BP+Xm8IZOt95CY9kDQpeC/NXGVTN7g43z+Zege7JO5daR0LTet8SfasBBrRY3va
         H1L4OCxnfweb/24+Fgmo5cIcyoAO6t3JsT+kRZlQpOVL22B/vt485SiWhpaO4VgtbqRI
         g4uhvlJobOYgndKUTXVEajOz9m8WN1gr275RmaWYrRyrI22goOKfpL6GGtLXdJA/5LLl
         Po7ImPRbOO5x3+lfcJbdWrA3DBsNnPWrOXE/9GBWWMOBUta8/Ost7/XhxFGrA4rBhqbJ
         1QWA==
X-Gm-Message-State: APjAAAWSQEzruIwZfQcMmIriGe2xRksEyicYxjP40flG4h+HRcpXggiM
        BKLXInef3+e7bf2VZbscKOsZEN39+U4=
X-Google-Smtp-Source: APXvYqy9XLs5PK9WQ1qesRfD+g8hZ33bsSWsjYCJxHeVBJYOkVzvPBT7w4zngmuynOba3fCGcdRUXw==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr47343714lfh.177.1564348647215;
        Sun, 28 Jul 2019 14:17:27 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id q17sm10350957lfn.71.2019.07.28.14.17.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 14:17:26 -0700 (PDT)
Subject: Re: [PATCH 5/5] spark/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-6-efremov@linux.com>
 <db0f3329-898b-d018-a5ed-cd7bdbd649bf@physik.fu-berlin.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <e989188a-2715-0ce8-5bd9-dbc2baddf475@linux.com>
Date:   Mon, 29 Jul 2019 00:17:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <db0f3329-898b-d018-a5ed-cd7bdbd649bf@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

 > Typo, it should be "sparc/PCI" in the subject and "sparc-specific"
 > in the commit description.

Oh, sorry. I'm from the area of formal methods and mechanically typed 
spark (ada language) instead of sparc. I will fix this in v2 after all 
comments. Thank you!

Denis
