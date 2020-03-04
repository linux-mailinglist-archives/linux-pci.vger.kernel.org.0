Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348BA1793B2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCDPib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 10:38:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDPia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 10:38:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2948521wrn.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgKNIbiOOYUUhf9VX9b+pYwCqt61P9QUYyLGCfaRQqc=;
        b=xw8uHB+1gNxz+4nuw+2nLyDwmL1QI5esVQO6EGJsBylGKEJSkntlHBqiPkEjo6I5so
         2j2NYcXAd8eVJR5NuQBvnBohvKncJiDbZj1YRtCntDcsklLInje+Nvh3wvu6cFWPFTTS
         CWckFMsVTrr5BiBsV/nqAMSc+QBQHT/7dMW1rdOjRzfzZcIFkiFXUUHtuTmHjXvS6y2W
         3EOPNRQRVYMoR5mWF82I5IEP576nXKWDhNiThT+JDtUY8BTwBkbwMsgIpwAGppFNz4qC
         5VoJpJuo69c3oRw5Vn1DUT3/o+NcGLYRIKIbO2iJu1RLprBCPQJ+OR08RXSDt3rv8wBR
         mkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgKNIbiOOYUUhf9VX9b+pYwCqt61P9QUYyLGCfaRQqc=;
        b=G+Dpg4rwzVDxa/HGvD/9ForwMuw+PW3olFHPNdeHHTxTYSG2tC5VxPK/SMztm32Ls/
         vov/NlSMQY2FdxHPD9Czra2lFVYe0g4Mn9L2gf4RQ0Isd1SamUrHw9yDhCv24qBWtKJV
         Lpw68ldnqE7laIuAlhCA6HBhHXTYUpQyM8IQA6tyauyXN+4hwZn6OMXqC1ZprnATgsNT
         ThmmCAJK1zWVuRIImQkiYqVEBawC41Q50rwRspPyaQk0eRMliBjsZsU7KWqZM7JJjVSN
         LgDHIuHyvOSMJPbQNUO77QSKKTNvG43xU7GU0Iffc0zY1ar8q4dguuZPcHf2YvlYFbL+
         QqcA==
X-Gm-Message-State: ANhLgQ1RetZIiyBWv5G/dIy13w+/VgY7x7BRFwbc816l40m+5XdNLpds
        T90Ade8HpR3NAufWIy0qltdrdA==
X-Google-Smtp-Source: ADFU+vsqYupk4jr/XDRtdoMwn9PUODaP8+a/LVXxe3xIMUBcFgnIFdwKRkeedg2yIubmDqV6LuPYEQ==
X-Received: by 2002:adf:a512:: with SMTP id i18mr4675381wrb.61.1583336308173;
        Wed, 04 Mar 2020 07:38:28 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g129sm5695847wmg.12.2020.03.04.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:38:27 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:38:21 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304153821.GE646000@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304133707.GB4177@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 02:37:08PM +0100, Joerg Roedel wrote:
> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.
> 
> If its that way on PPC, than fine for them. But since this is enablement
> for x86, it should follow the x86 platform best practices, and that
> means describing hardware through ACPI.

I agree with this. The problem is I don't know how to get a new ACPI table
or change an existing one. It needs to go through the UEFI forum in order
to be accepted, and I don't have any weight there. I've been trying to get
the tiny change into IORT for ages. I haven't been given any convincing
reason against it or offered any alternative, it's just stalled. The
topology description introduced here wasn't my first choice either but
unless someone can help finding another way into ACPI, I don't have a
better idea.

Thanks,
Jean
