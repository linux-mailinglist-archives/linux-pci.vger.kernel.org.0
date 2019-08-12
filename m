Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197F88A915
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHLVOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 17:14:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfHLVOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 17:14:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so105825295wru.13;
        Mon, 12 Aug 2019 14:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bf5EEMuQJ8I7zXlqZc3Yp5KPqhakmwIzRIocebTFYaU=;
        b=U1Aii+r1L7INEQ4mV1DcH9a1kdVRZt4+F4vbpQgZU0z8irjyHxSCha6XBlzOwq+0hw
         2KHjlGtr2OUXqO0nnqadVnx9hWDnQ/0TZ7eRpMcZdTEh6arUoclk3TSKsNIASZYh+UHr
         V0Lrj2/zh+qIQjNURizwMrsHRoHlXzi3grvJR5HLzROv3ijs4paJfYk/E0K5sLssoCOF
         kSEzFk/YPiw8gkTxl6fmqPKI66I1a4Cx5cqE26oaM2jgawArc7kaRJdKyD7L07Lee6NT
         BDq7RKU8v8L4sK/3N/oCVIxotlZGif9sgWQoj+BGCNo/mB33UcT3xA9ZYHhdnPW6tSmG
         q4lQ==
X-Gm-Message-State: APjAAAWmxFFhjJvNO5OVXGXfKuWFnd9gnkRlCGVM1/mJrZP9IiRdVfbr
        XeSmxSWnXVspfKenTA1z845lQoQQQc0=
X-Google-Smtp-Source: APXvYqyHrCg/SBbpcO+GaWIgRY5ig1WwSB3MMB/3Y6y9/oYTpP1qN8QDTx92AfOmZD0bxVCA8BmrBQ==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr41944410wru.195.1565644449642;
        Mon, 12 Aug 2019 14:14:09 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id n14sm209762486wra.75.2019.08.12.14.14.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 14:14:09 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-5-efremov@linux.com>
 <20190812200330.GH11785@google.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <b948bc25-e643-a43c-de70-136a041f13b1@linux.com>
Date:   Tue, 13 Aug 2019 00:14:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812200330.GH11785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> You must have a reason, but why didn't you completely remove
> pciehp_green_led_on(), etc, and change the callers to use
> pciehp_set_indicators() instead?

Well, I don't have the exact reason here. I thought that it would be nice to preserve
an existing interface and to hide some implementation details (e.g., status of the
second indicator). I could completely remove pciehp_green_led_{on,off,blink}() and
pciehp_set_attention_status() in v3 if you prefer.

Thanks, 
Denis
