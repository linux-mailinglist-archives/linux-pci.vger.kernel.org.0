Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB213D0B6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 00:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgAOXlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 18:41:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35418 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOXlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 18:41:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id i23so9269714pfo.2;
        Wed, 15 Jan 2020 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b73rwoFfpR8fYFeTkhSZQtojQ3pztbWAc7w+boMg4hc=;
        b=cMxSg3lUGcVqK8YukUF9N8Em8iJ9jZDOJWnsEFdJSXtJedlZnrhSv4RkfVYW1tp8qc
         t65T+ZBM3OkMDH/Bbs3udiORYAzNVLFxui7FFsIr22pyM/lrHTX89HcZ55LttLxtyQaE
         Tc2OxtVOjvJj+7g3tUnDDocHQCqHobVxUljpqK7tgvctsXV5OILaLneAtFxl9wDmDaRZ
         CLMhsj5X3bUgXwYQbqmh8pJxGANuxV7g/pwjNzRjQZ7HG/RE3nsEP7AftQ/JSKkCjZGT
         a9neJBwNXxdo1hp1RjjQv7W0R87hYBt3YbwlUDDeqqqSZLBaELXU2eScKAUTpx4Pqb14
         rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b73rwoFfpR8fYFeTkhSZQtojQ3pztbWAc7w+boMg4hc=;
        b=ZUlXtOhmeX/Oe1xfqZpx3GaEH56F0JGrAreD2zqLSFZhz0U9SLBsYq5r6Gr167d7vR
         oF0WzeS8F0UbyC9T4yKNhIPn5ZCItETQZ0XE2XmpkL4AcXYoexI9hPs4cWMF3ZAiRihO
         9xK1FoDfYlBq0nvYOn6nsRxa87uFO+zj6EbPHsYTFIb1G7HuhdwlPlL+kpdUAm8ly2Mf
         R9Lez0NCz7kdTI6l0cGFfcJzylqCPTDVxuw997NuonlPcQgW4/gACmk60X9BBxURc0ud
         tbmRTSURm7i2ICCJ/G9p8xl4r1WYG0ZnTMBgIkjjcUo2c/O/alO5iYm5yMqPT1cAKV93
         WDow==
X-Gm-Message-State: APjAAAWBxor8BhG7LhYjdXYBwrvGs+JEpjL7nVBiOp6TJ/C1QqFtmiiV
        C8DuXqqQMOAsSzCz/dw0tRQ=
X-Google-Smtp-Source: APXvYqxAvazY9uzyIJsUVYRpxDwmQnZqVBWXjDxMnMkNkwcAycKpsR/9HvNNAYO7frLJIVEeb4PvNg==
X-Received: by 2002:a62:e509:: with SMTP id n9mr33567862pff.159.1579131673713;
        Wed, 15 Jan 2020 15:41:13 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y62sm24933344pfg.45.2020.01.15.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 15:41:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, wahrenst@gmx.net, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/6] ARM: dts: bcm2711: Enable PCIe controller
Date:   Wed, 15 Jan 2020 15:41:12 -0800
Message-Id: <20200115234112.30746-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216110113.30436-3-nsaenzjulienne@suse.de>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de> <20191216110113.30436-3-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Dec 2019 12:01:08 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> This enables bcm2711's PCIe bus, which is hardwired to a VIA
> Technologies XHCI USB 3.0 controller.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---

Applied to devicetree/next, thanks!
--
Florian
