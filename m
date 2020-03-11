Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC31182432
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 22:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgCKVsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 17:48:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37771 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbgCKVsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trXAOUXf8R0jK9KyR9z+fLazglkIkKVNTDuFFKwZMaA=;
        b=BSqLuFdRBCWqKYgQFMFCc+hvccUyqrKfC93WDQDwqhgq5GTmtD0rrAFhwaaTgKW3C428yv
        7YqVhKMf3+vkm+Pz/+A498SSVnCrWIZZ+5zywmx+l0hSI5EQlYYdQMFbckJRQ69yUEF3ka
        dkPoYkcVQN5gr4zbGVg/ib+ic2WwfS8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-L-ET6tziOcaWsQyOK02oYg-1; Wed, 11 Mar 2020 17:48:29 -0400
X-MC-Unique: L-ET6tziOcaWsQyOK02oYg-1
Received: by mail-qt1-f198.google.com with SMTP id a21so2190525qto.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 14:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=trXAOUXf8R0jK9KyR9z+fLazglkIkKVNTDuFFKwZMaA=;
        b=BqfSZvY+WIxz3+A2vAe3A3EwoRKyYhFZMPtfYrHwjfwRr51dpjf3eZoQzKT/EbnYqC
         023NzXojjiaw3TYj8+gt8hxWkcWlsLSx+OfxWbRuF00vecj40rYbNE4q10z43NgQFUYk
         ArjxfvC2ksNayWLKSddfOMu6S3V8Em/eEDrBNhGeM61K5C8wSMqiDFg+Bczb6qK02s2p
         NdRWKe4eztR8JpSbznB69m1l0KdaS0QyTXluJDUH9lWoWGIVXPa4G7eD9b3zGU2D9bfB
         ch3xyaicFjLBeHwwgsHZE81d6UDdzw+KODG4p/A2u7n6hWfgMqB33kfJZeuZXZIHKTXm
         LYrg==
X-Gm-Message-State: ANhLgQ3rhdWr59kZAYSLAdmAYEVduTJYlmSI0rYnq45L2MGErBFYEPX4
        E3mo2E4upiO31QyOCrc6N7ToQg4hQ5JwJHB3NjPycaAtmMgn8wMlxtTuZYP2Qe/++KB2jtjvpuF
        g8ROb+g2ZXdUgXxTLmhzC
X-Received: by 2002:ac8:4d83:: with SMTP id a3mr4594410qtw.259.1583963308860;
        Wed, 11 Mar 2020 14:48:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtsEzdKfH7m2m28mgkpshSZzeyzQQNiRjBtaqGOgSv+gSun0NAQfBN9Lban03PlKiUdtVlsFw==
X-Received: by 2002:ac8:4d83:: with SMTP id a3mr4594391qtw.259.1583963308679;
        Wed, 11 Mar 2020 14:48:28 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id g7sm251268qki.64.2020.03.11.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:48:27 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:48:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200311174348-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
 <20200311174822.GA96893@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311174822.GA96893@myrica>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 06:48:22PM +0100, Jean-Philippe Brucker wrote:
> Yes "not elegant" in part because of the PCI fixup. Fixups are used to
> work around bugs

Not really - they are for anything unusual that common PCI code can not
handle on its own.

-- 
MST

