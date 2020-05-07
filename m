Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE00E1C9DE0
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEGVtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:49:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37663 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:49:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so6614022oij.4;
        Thu, 07 May 2020 14:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E+pFlkiHBg6jfWtAOY9Q6oDR0NcYcDN9gR56ePg57Lw=;
        b=j7tTRoK1G/wXJcNrT/oK1nqYl3X3RJykY4LZbRKZqwcRZX4SgSYcDy5PhNp4Sdz0Zt
         vzqWfWujsifC4Gzhl2KDNT2V8cfcZvuYvkrCybnPBJmXgHxRYWz8e9kg93lsvzq0Mdxu
         koDDnjaLr53vyJQWyHlgJynk5xtGS2BJ/Cjdun8FvO7iPZP+odiVlrJn+Hwm3JENN4c4
         M6J2HCQtXsMcP1AoVmeM0yvBBTuAaOH8Vn3xVPr/bEttCRskayArxd2n8VYf7HI07+9Z
         h0qc1k6zs4etOvSh5r2lEzE9hEczMdKvahO9qzLJU8Q1ur+qPqsq9Qpi7g6x6i2lDbs8
         UcNA==
X-Gm-Message-State: AGi0PuacUVDkfBhcxKhiBBUaWBWxJq8ZxJUMaaH2zdyVW0VlxnHCVj5t
        Jy2z4+8Fyytp69sw/4dWyA==
X-Google-Smtp-Source: APiQypIayKJpxvDexGfbRNvCnUfO7rkllRn/IREbyBex8nzmd8858FJDRmdqI9CIiLxCQubNsW8bZQ==
X-Received: by 2002:aca:4951:: with SMTP id w78mr8756772oia.99.1588888141372;
        Thu, 07 May 2020 14:49:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f9sm1671435ote.30.2020.05.07.14.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:49:00 -0700 (PDT)
Received: (nullmailer pid 632 invoked by uid 1000);
        Thu, 07 May 2020 21:48:59 -0000
Date:   Thu, 7 May 2020 16:48:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        tim.gover@raspberrypi.org, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
Message-ID: <20200507214859.GA562@bogus>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  5 May 2020 18:13:15 +0200, Nicolas Saenz Julienne wrote:
> The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
> that implements xHCI. After a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> co-processor, VideoCore. RPi4's VideoCore OS contains both the non public
> firmware load logic and the VL805 firmware blob. The function this patch
> introduces triggers the aforementioned process.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Change since v7:
> - Use usleep_delay()
> - Add comment about PCI errors
> - Don't wait on error
> - Typos
> 
> Change since v6:
> - Add test to avoid loading the firmware when not needed
> - Since we have it around, print VL805's firmware version, it'll make
> debugging easier in the future
> - Correct typos
> - Add a clearer view of HW topology in patch description
> 
> Changes since v4:
> - Inline function definition when RASPBERRYPI_FIRMWARE is not defined
> 
> Changes since v1:
> - Move include into .c file and add forward declaration to .h
> 
>  drivers/firmware/raspberrypi.c             | 61 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  7 +++
>  2 files changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
