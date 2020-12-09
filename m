Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171142D4CBE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 22:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgLIVVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 16:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbgLIVVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 16:21:02 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E30C0613CF
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 13:20:21 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cm17so3188377edb.4
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgu5SGKx1gsYdy9j4dOrYrsjFJDAyhP/ryB0BUE7zio=;
        b=niQBzCOYtIl/hSI517HSDdPqg8oTrgM3dfRFRWH3fUdOBclueW5rO1xnYYbVKxAInH
         isd9w2yJkKDLEZ98RuhEakRekizvzPuzsJDwX7wiyIXVzRK6heZVnpwz3PNrrgiaId4P
         d7/rpIN+kmbcLiN/07eSzUn+jYBO048TqSHvFhh9i+ZNZa6kFaa/gGCp8o+nbA4nomyV
         kW2pjY8jqBAzm74LjOd6HBS8uTK71WBhGWe+iH3j1SyaYnISaxA2NqA1CSOS2T32aTD1
         HEsX/+nKGrYwAl2l9I01Eh+mZV2kBGwrVFkvI8J6qi8sPp7/OM8Ec7kyiHqsMlJhgVKP
         KtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgu5SGKx1gsYdy9j4dOrYrsjFJDAyhP/ryB0BUE7zio=;
        b=OkaKCAkvwA6JI499EFPsLuDEbGIhtxLWPq43jNdrHbwnYjkl9TTQChMtiRADplaQPE
         /RR4IlNtSj5j5vxh5+GnQlHw9q1TcnvqnsEFZuW8G8TrRU1U7RR37XAc+2Ayk/qw7iRp
         lKTJTO7o3IHJYcglOiW+ZvP9vX7qkaptp9tBL+HCmSV7Mn0et3FRpEpJEQcgPsc7oZMo
         9aLoMRnpDwkx+5uKu8kcGUa0Pl7Mu7EDhmGtArBG4Tdmbu/vD2rZFcVHzqe6WkiW3x0m
         Cu5QtCXxP3X+2zxz7Ipx0cvbOiKiXJwQQYAolvw6FAlpA6zbJ3MXlmZIhoc+CsDBX31O
         1nHw==
X-Gm-Message-State: AOAM532eXDVtYP80W7KztbGXOCtnovkiOmdI2lgmqLUifHL+AKV8eYzm
        Cnpq0MrEYZ23IcrZXu2jmVM=
X-Google-Smtp-Source: ABdhPJznqu5V3gX6VcnRSs31xSg7oHWhdE8I8tSsQuFGa09jBY2GusA8WWIa3CyUu6L7fV1c5sghOg==
X-Received: by 2002:a05:6402:149a:: with SMTP id e26mr3491125edv.150.1607548820494;
        Wed, 09 Dec 2020 13:20:20 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id mb15sm2561294ejb.9.2020.12.09.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:20:19 -0800 (PST)
Date:   Wed, 9 Dec 2020 23:20:17 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209212017.vx7dps3jasjcwg6j@skbuf>
References: <20201209202904.2juzokqhleusgsts@skbuf>
 <20201209205913.GA2543692@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209205913.GA2543692@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 02:59:13PM -0600, Bjorn Helgaas wrote:
> Yep, that's the theory.  Thanks for testing it!

Testing what? I'm not following.
