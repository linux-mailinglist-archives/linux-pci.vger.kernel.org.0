Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C23BA54C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGBVxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:53:51 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41522 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGBVxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 17:53:51 -0400
Received: by mail-lf1-f53.google.com with SMTP id n14so20558787lfu.8
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 14:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eC5EMVrXypfbykVCTo3N/7mVOAJODxfxkHhFu/vq3Vk=;
        b=o53cp6v5V9BsYaF8pO9H5xNanbR5TzBEP0G4xZbGAxNO6ay7iD4/eTIA6p0WCx9fwY
         8ruHQQs2aqFjTQfDh2Bc2qyU09at1c0mGUtOqXtkmN76Fia9I8Qh3nNPunAS188C3srv
         TT2+PSwPeGzyuA+S+lFWp0Gr8yhoxCOL8BQ09jTle+yy6fvoRaxPLzJJkxNmOLf7YPgn
         xImZY3sgmeMjvYcfDzvi49kkcP/jWP9u1WI3YcuY9KP1MruozxEnKDfTiZNweouLcJVJ
         xoVnIWNqaInmj8zaVVm3fGMeg6kb4KU03R1AHjtkcrWvLTwqW9Hghwi249rh+IXvv09n
         3eYg==
X-Gm-Message-State: AOAM531Eoqr9Tykt3ABItefzCS5rPWIs+6msNE7geLwvVTzCg7dCxyFD
        WHWxxLGYFXRhF0iaxgEqqB4=
X-Google-Smtp-Source: ABdhPJwFn39PViBlv5O5e1+r3CAYKP/5yWLVHnWJZjFIi+KLElUgTsXxCHAcsX3QGuppHaeZckkb8g==
X-Received: by 2002:ac2:4943:: with SMTP id o3mr1255849lfi.274.1625262677057;
        Fri, 02 Jul 2021 14:51:17 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o11sm380761lfb.218.2021.07.02.14.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:51:16 -0700 (PDT)
Date:   Fri, 2 Jul 2021 23:51:15 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Fix kernel-doc formatting and add missing
 documentation
Message-ID: <20210702215115.GA397845@rocinante>
References: <20210702214055.1663227-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210702214055.1663227-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I am going to send a v2 of this patch, as I wanted to include more
changes to fix issues related to kerne-doc usage within various
Hotplug-related files.

Sorry for the commotion!

	Krzysztof
