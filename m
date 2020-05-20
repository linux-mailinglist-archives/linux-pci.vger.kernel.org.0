Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB51DC170
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgETVei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 17:34:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45493 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgETVei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 17:34:38 -0400
Received: by mail-il1-f196.google.com with SMTP id b15so4829925ilq.12;
        Wed, 20 May 2020 14:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/eHyYzBahdn3qW8t/qbKdgzArvvt9PLcDPFzWfN7iw=;
        b=Y09C3B1cckuQqTCBYDEb64L/znn52kjYwWudOrafnSJBlubrOIGJ2fNMALM1oiigMM
         DLd5PImrhRX8jCFC6lghu1oQ4ymL1Fty3fooUvMbdy6RHAlXcSGO5Jxyts9/Q1bBSSFV
         impvfSnc4WNY+rrxdzoavrGnkqT041/yJa0IGP/vl85EXB1/tKVl4uN+i9T0nT4vaAwB
         yE+vrp3TWWuvia6/YZmlGlZ/INMF+cD0hsjnYjT2a/ndPJSULDsgKkLbErvTqI+FoupK
         Mu6rxzPQeFoUdx2ryluJ4q8P4ONDnrSDYdzZ/wN0920ucRAbz5IKWmDKRCLxCZCHWk25
         y6rA==
X-Gm-Message-State: AOAM531cwNZhk2O4pKHCO0gZg0whfeu1pKEtqr9ao/gsplaGrbG/W9EF
        V1CFF/v+Nh03N7DAbwCuqg==
X-Google-Smtp-Source: ABdhPJzKftdjlLVMTI+ImBLO4uTp+xrXfJIyzLp9JRWBEvw9KfywvQPPZEg7GO8i9fwFyIbrHDhAZA==
X-Received: by 2002:a05:6e02:92d:: with SMTP id o13mr5836790ilt.142.1590010477107;
        Wed, 20 May 2020 14:34:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a20sm1642056iot.17.2020.05.20.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:34:36 -0700 (PDT)
Received: (nullmailer pid 633250 invoked by uid 1000);
        Wed, 20 May 2020 21:34:35 -0000
Date:   Wed, 20 May 2020 15:34:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 07/14] PCI: cadence: Add new *ops* for CPU addr fixup
Message-ID: <20200520213434.GA583923@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-8-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-8-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 08:44:22PM +0530, Kishon Vijay Abraham I wrote:
> Cadence driver uses "mem" memory resource to obtain the offset of
> configuration space address region, memory space address region and
> message space address region. The obtained offset is used to program
> the Address Translation Unit (ATU). However certain platforms like TI's
> J721E SoC require the absolute address to be programmed in the ATU and not
> just the offset.

Once again, Cadence host binding is broken (or at least the example is). 
The 'mem' region shouldn't even exist. It is overlapping the config 
space and 'ranges':

            reg = <0x0 0xfb000000  0x0 0x01000000>,
                  <0x0 0x41000000  0x0 0x00001000>,
                  <0x0 0x40000000  0x0 0x04000000>;
            reg-names = "reg", "cfg", "mem";

            ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
                     <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;


16M of registers looks a bit odd. I guess it doesn't matter 
unless you have a 32-bit platform and care about your virtual 
space. Probably should have been 3 regions for LM, RP, and AT looking 
at the driver.

Whatever outbound address translation you need should be based on 
'ranges'.

Rob
