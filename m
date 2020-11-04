Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB42A6F41
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 21:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgKDU4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 15:56:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgKDU4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 15:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604523373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ungWZEU+yvjjoS5G8bkpuxo9OeZDZAgv7pFGe3veP9o=;
        b=hWCL1b1aw+rlwwiBn01J9qlsvBqh6tFFS91mo1UaXnvn3ZHZHPcjnzZbxWTxknrpGhMPRK
        pXdnAgRl5ewUvJ/PW0cB6vcH3NjEAf+VVZq6H5NlIjWpx37PXw99/z5ViHfBqmUScG3+pG
        4CDVqZMHgYxnMXLfmML0az/9MM6b+Sw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-javnuzIuOHyL8EysIDriQQ-1; Wed, 04 Nov 2020 15:56:05 -0500
X-MC-Unique: javnuzIuOHyL8EysIDriQQ-1
Received: by mail-io1-f69.google.com with SMTP id z18so44295ioz.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2020 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ungWZEU+yvjjoS5G8bkpuxo9OeZDZAgv7pFGe3veP9o=;
        b=rpGuVvod8pcOXUp45tM89I5ntkYYb+0PKN5+ujP8Q6mJmsEB9Rw3RRpE6TUrKgnYMi
         0PevnP1D7aAHhcVXFFaF4CMKTbisnBSme6QCmWzubPahPk8EsrfujfZ1EcA9cyDNXdF7
         o7UihOL7go0CzSeUY7SPOxA19m5kMK+KFkRiC1noKQ6OnRO54u3Zu3CCEnyi7+ogzjjr
         ACyCO1xsXThFmv1PeMDHAdRGy0WPiVoAIjBRNp7t5D4uWq1QoDR6dFgZ826GYXpEhD3C
         gSbvsqb0/C7ShCebwljEpEcw7jROimWlDDs+pvp/ksE48Qp3hvcayKo7/ZXWqk6VFsSA
         Rs0g==
X-Gm-Message-State: AOAM5314Z8ZTeHHiVDvBg0eNr1wzjl4rYgzeaLvnAAZBsuxCSFc/OmJx
        oEm2cRuggpNITCCSnqD27GAIEf9WG0SEDFvtv0nCc2TV/HG16dM0dS0MZn8xg45g0rO/SADh0z1
        3f96MwfUPvedVa+AO0+zM
X-Received: by 2002:a5e:930d:: with SMTP id k13mr18717873iom.33.1604523364844;
        Wed, 04 Nov 2020 12:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9u4/qSIawBf44kt75ww1KZMdwyP+XEBi83reLCrwbrdxCuPZmQOU3/rFLRD3cDEMeh1PFbQ==
X-Received: by 2002:a5e:930d:: with SMTP id k13mr18717853iom.33.1604523364672;
        Wed, 04 Nov 2020 12:56:04 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id r14sm1996341ilc.78.2020.11.04.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:56:03 -0800 (PST)
Date:   Wed, 4 Nov 2020 13:56:02 -0700
From:   Al Stone <ahs3@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201104205602.GN1557194@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
 <20201103200904.GA1557194@redhat.com>
 <20201104093328.GA505400@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104093328.GA505400@myrica>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04 Nov 2020 10:33, Jean-Philippe Brucker wrote:
> Hi Al,
> 
> On Tue, Nov 03, 2020 at 01:09:04PM -0700, Al Stone wrote:
> > So, there are some questions about the VIOT definition and I just
> > don't know enough to be able to answer them.  One of the ASWG members
> > is trying to understand the semantics behind the subtables.
> 
> Thanks for the update. We dropped subtables a few versions ago, though, do
> you have the latest v8?
> https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf

Sorry, I confused some terminology: what are called the Node structures
are implemented as "subtables" in the ACPI reference implementation
(ACPICA).  But yes, I've proposed the v8 version.

> > Is there a particular set of people, or mailing lists, that I can
> > point to to get the questions answered?  Ideally it would be one
> > of the public lists where it has already been discussed, but an
> > individual would be fine, too.  No changes have been proposed, just
> > some questions asked.
> 
> For a public list, I suggest iommu@lists.linux-foundation.org if we should
> pick only one (otherwise add virtualization@lists.linux-foundation.org and
> virtio-dev@lists.oasis-open.org). I'm happy to answer any question, and
> the folks on here are a good set to Cc:
> 
> eric.auger@redhat.com
> jean-philippe@linaro.org
> joro@8bytes.org
> kevin.tian@intel.com
> lorenzo.pieralisi@arm.com
> mst@redhat.com
> sebastien.boeuf@intel.com
> 
> Thanks,
> Jean
> 

Merci, Jean-Philippe :).  I'll point the individual at you and the
iommu mailing list, and the CCs.  Sadly, I did not write down the
full question, nor the person's name (from Microsoft, possibly?)
and now seem to have completely forgotten both (it's been a long
few months...).  If I can find something in the meeting minutes,
I'll pass that on.

Thanks again for everyone's patience.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

