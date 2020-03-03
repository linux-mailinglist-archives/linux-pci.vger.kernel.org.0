Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523A6177828
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCCOCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 09:02:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728568AbgCCOCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 09:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583244151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vURXmaMa/jNw8/wDeynB3tRJrpHBF8mvDGbk4U2gsFk=;
        b=CdDnilo2CaRiZcQGnSgCW1FwlNhcC+MA8v3HLKVxjj1ntlnDudZvf6jpWo6RWQi7jqzham
        ZI1Z8HjYboMewTfRRrobe7lUDD2y0bLpfCi43yYg2moVLSkvRRxDfYns5eCLadWCssuQDa
        e+ekJ8VBFp+bwBljOuySa8ahlYI3zYs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Qg1pKOhPP8Wu9r3KCrqBeg-1; Tue, 03 Mar 2020 09:02:30 -0500
X-MC-Unique: Qg1pKOhPP8Wu9r3KCrqBeg-1
Received: by mail-qk1-f200.google.com with SMTP id x21so2161480qkn.18
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 06:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vURXmaMa/jNw8/wDeynB3tRJrpHBF8mvDGbk4U2gsFk=;
        b=hDLeEo0jvDA2a8ADJnkP5XBsdK5AelvL6Wtd9toMG9tJCDY1MMEyefj+DXBHW+LMR0
         FPzHcsmqirrZSyptgv7hlOOZL0D8KPsWDopavFJqtRsQZg/1eQz2c0cF0cMUTEHb1+OO
         V70IdhBXoOmPT2fwOcYkqPtTDT3ytmoY7vnI8Zq/g3J8Hi2TrGY1GHCc+KSEQ5huHp1D
         PWnN7uaUF9J0ADo1nb+t2afrU8XpPcWSIDNWEUAEsQ7sFfUxEobvBFBzAmaN7KD2wZfU
         2cf5qILYV5Em8ftVJbA6ScHXsAw5evh59avZ0KdEy2wtk6HUk9Z+sS7BRWlAlFNVQrgz
         pWUA==
X-Gm-Message-State: ANhLgQ1EK2T/B7jM5ky8ruvbz9lQ5Nim6Q14al1wh68td6/PW0+EkC7Y
        4GAp3bplB1o0rJLyhimpajWMRNY0QGnPv9edaB4gSEmPIf6tUppCT8Zwxii2pgpCE9/Wt3D3LKP
        7/Q/vEKjNmrGKF3KYZyop
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr4331359qth.85.1583244149957;
        Tue, 03 Mar 2020 06:02:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsrHkcUNU/JWr3iaSlnrdpMaoXDL9dgR2gjUhWQ2iO+BPmktHURohbRSLr525HkXxY5rlNBXQ==
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr4331328qth.85.1583244149723;
        Tue, 03 Mar 2020 06:02:29 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id j7sm8343441qti.14.2020.03.03.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:02:28 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:02:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200303090046-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302161611.GD7829@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 02, 2020 at 05:16:12PM +0100, Joerg Roedel wrote:
> On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> > This solution isn't elegant nor foolproof, but is the best we can do at
> > the moment and works with existing virtio-iommu implementations. It also
> > enables an IOMMU for lightweight hypervisors that do not rely on
> > firmware methods for booting.
> 
> I appreciate the enablement on x86, but putting the conmfiguration into
> mmio-space isn't really something I want to see upstream.

It's in virtio config space, not in mmio-space. With a PCI virtio-IOMMU
device this will be in memory.

> What is the
> problem with defining an ACPI table instead? This would also make things
> work on AARCH64 UEFI machines.
> 
> Regards,
> 
> 	Joerg

