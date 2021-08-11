Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1C3E9B6F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 01:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhHKX7L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 19:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232976AbhHKX7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 19:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628726325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1SDCuE9HIfXjsh0hcgg+dRfxkP6S2YlXEMZFhz/yOI=;
        b=H21NYnh4hnRKS4k4SNtysMCjzErtLGhzLhF+bn5FJF/SBkW4UvfSPvoHQZPjvWf878aA/n
        z1oUpFLvoIJ9BRZvA91T2LqIFYbXAmrbpLCa1dXiI1mQHyTFTXn3ZqpycJ1Fj1gwCddCkz
        evMgEdKLjAVWLm4+ug9PcKLspaSo44o=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-wcZT7bcTMQeWJ_6ERkUVIw-1; Wed, 11 Aug 2021 19:58:44 -0400
X-MC-Unique: wcZT7bcTMQeWJ_6ERkUVIw-1
Received: by mail-ot1-f72.google.com with SMTP id w3-20020a9d45030000b02904f2593b1966so1562465ote.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 16:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=R1SDCuE9HIfXjsh0hcgg+dRfxkP6S2YlXEMZFhz/yOI=;
        b=cHexxytX0YW/IAp4LWbQdaYyneWPvQmUnlRmjtgcfkbEQEpROLQm0PHozenS/UoJil
         xiRE4Xnp0V3x/1SX3/alEw9R7pVfMwEtuVuMH9uj4hxP+CRP5lYh3u8cUB+JzUWHewyv
         G+dxa1jvoh4dQkTzmxmDcSEunzn8eEidRwGpQ9pPUATe5d1HyXa25qmh9kOasC1X76LX
         1G1isDdOV9/oLv40NkvtJI7LeUPZcO3qO3EB1YAzqVE8TBorCg+x1/Nxr7IpAGNBcf9c
         9zLC5ASSrGSVwU5Uyv/1GA4MzLINvveHUXCFWhKO2HZ5YBcZJhqRMy03iY/xKN2SACko
         VD2A==
X-Gm-Message-State: AOAM533MzRy+2lN8Jo+T9yCkmsO/qci49FxCRQ6lynWT+4lYrHzKkEdN
        4yj6htp4EQEAOLPDqA0nRalAKXmNs0GTeP4YKbVT8qY7DzKzGXsWjlEoukOlLDeASnFWSfwWbQO
        yOtWvwmbZQJbo3BxzvKIQ
X-Received: by 2002:aca:1b08:: with SMTP id b8mr1187562oib.44.1628726324006;
        Wed, 11 Aug 2021 16:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8VTM116CvZxA/6bXlCTWuf5mQk4eVK99MUaa//hfHZGWebkErn3S5uA96XMT5zv2DxlgkVg==
X-Received: by 2002:aca:1b08:: with SMTP id b8mr1187560oib.44.1628726323844;
        Wed, 11 Aug 2021 16:58:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id q7sm234794otl.45.2021.08.11.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:58:43 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:58:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: [PATCH 2/6] PCI/VPD: Remove struct pci_vpd_ops
Message-ID: <20210811175842.2ed7c87b.alex.williamson@redhat.com>
In-Reply-To: <81BDA19D-B2AC-433A-B16F-4EB88A070B5B@intel.com>
References: <20210811220047.GA2407168@bjorn-Precision-5520>
        <81BDA19D-B2AC-433A-B16F-4EB88A070B5B@intel.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Aug 2021 23:43:43 +0000
"Rustad, Mark D" <mark.d.rustad@intel.com> wrote:

> at 3:00 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > So I wonder if we should just disallow VPD access for these NICs
> > except on function 0.  There was a little bit of discussion in that
> > direction at [2].  
> 
> If this is done, you'll have to be sure that any non-0 functions assigned  
> to guests (which will appear as function 0 to the guest!) does not appear  
> to have VPD and block access to those resources. That seems kind of messy,  
> but should work. One hopes that no guest drivers are hard-wired to assume  
> VPD presence based on the device type.

A bit messy, yes.  But if we're saying VPD is not essential for
operation in the VM, I'd rather we mask it on all functions rather than
create scenarios where different identical functions produce different
userspace results.  Thanks,

Alex

