Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30556278AAC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIYOPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 10:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbgIYOPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 10:15:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601043301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2R3iNk7E6LuL+FhjbAyC15TLO61WWZH3nk3G89jYXq0=;
        b=cyMZqkEsv4jhpg5nHtzpp66hZ7Et+Hn1KJICqYDXmsejk4D4Lrl7wa7vFe3o15CQJEqHeb
        Imk8tWlz2cGopBb7wkXUFvctSA4liIRuIwGh0+EV+UwoqShBdCMPJ2OHc3Jvi1+cZAhuf8
        g5DIFB3/qSQ68OI6rcUWrO6h3DcktO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-W2P_d5LuO86xM8tPcyjomw-1; Fri, 25 Sep 2020 10:14:55 -0400
X-MC-Unique: W2P_d5LuO86xM8tPcyjomw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E34ED195D564;
        Fri, 25 Sep 2020 14:14:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com [10.36.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEFC65576F;
        Fri, 25 Sep 2020 14:14:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BCB7016E0A; Fri, 25 Sep 2020 16:14:46 +0200 (CEST)
Date:   Fri, 25 Sep 2020 16:14:46 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        eric.auger@redhat.com, lorenzo.pieralisi@arm.com
Subject: Re: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in
 topology
Message-ID: <20200925141446.63iwheqdrqxl3puo@sirius.home.kraxel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
 <20200925112629.GA1337555@myrica>
 <20200925094405-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925094405-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hi,

> Many power platforms are OF based, thus without ACPI or DT support.

pseries has lots of stuff below /proc/device-tree.  Dunno whenever that
is the same kind of device tree we have on arm ...

take care,
  Gerd

