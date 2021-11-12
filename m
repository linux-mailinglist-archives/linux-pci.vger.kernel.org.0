Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670A44DF6C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 01:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhKLA7U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 19:59:20 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45938 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLA7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 19:59:19 -0500
Received: by mail-ed1-f43.google.com with SMTP id f4so30900094edx.12;
        Thu, 11 Nov 2021 16:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILyyi8QjSp1kiJ38sxFtC8IcpNL/iV0bSL1B4louovc=;
        b=23P0Rup7A5Dtk0n59yizWnz6dJdViQxmqsD7j2H7Guy6sIpjYbWtvDlI+nKthVOVMj
         tsjQJ8hLS18SOb2lE0pmScc2ybwlmLeTK/xKCX+g40+IGUIVGtibf9w7PHQn7oLk/Xm3
         Awrxq5V2p+K1K1O6FmE/81nxMuA7t5lKOFqBrGFwK/G5GtsgXfX6sYOsrcKLt+zCg2mk
         gIGDex0aFyUoUb6RUruGuJKpqPfhOqTQ70NHJ8atviQ7Uafxo2uawS9i0pZHB9J9+YUV
         hnBxCeXXIcH6PihmQM1qBEcct1eR9LdiEbudo1FI+Ykz1O48sxhVm7bN3JTy8OP1tFcf
         KaIg==
X-Gm-Message-State: AOAM533sBOuJqNSS0En0f+Xo/XprNIGq2oxTRq8qFkGkc+rY63LdgRN3
        C7YVm1LTum0skWqvmow59hY=
X-Google-Smtp-Source: ABdhPJzXubFYK2c9wpsc5PLlX2QszNt0lE30oFWWJux9hJ9zUgDD25KHTiLiNLKtxSGw84l5HVX0fQ==
X-Received: by 2002:a50:e608:: with SMTP id y8mr15291156edm.39.1636678588993;
        Thu, 11 Nov 2021 16:56:28 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id ho30sm2058172ejc.30.2021.11.11.16.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:56:28 -0800 (PST)
Date:   Fri, 12 Nov 2021 01:56:27 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Message-ID: <YY27u8IfLK6ffpI+@rocinante>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
 <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
 <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
 <19dcfbea-efcd-b385-4031-23fae5c1c78b@linux.intel.com>
 <4cb4d599-a146-2219-6c6a-c713f022bd7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cb4d599-a146-2219-6c6a-c713f022bd7c@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stuart,

[...]
> I've reworked the code so it is an auxiliary driver (to nvme, and
> hopefully cxl and pcieport, but I haven't added that yet), and so it
> registers as an enclosure (instead of using the LED subsystem).

Would you be able to post this new reworded driver as either a new
version or a completely new series, or even as an RFC?  It would help
to get a fresh perspective and also make it easier to review it.

	Krzysztof
