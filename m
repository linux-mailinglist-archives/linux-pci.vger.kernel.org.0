Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD654179B0D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 22:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgCDVhr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 16:37:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:34763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgCDVhr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 16:37:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 13:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,515,1574150400"; 
   d="scan'208";a="413294350"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.254.51.15])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 13:37:45 -0800
Date:   Wed, 4 Mar 2020 13:37:44 -0800
From:   "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jasowang@redhat.com>, <kevin.tian@intel.com>,
        <sebastien.boeuf@intel.com>, <robin.murphy@arm.com>,
        jacob.jun.pan@intel.com, "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rothman, Michael A" <michael.a.rothman@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304133744.00000fdb@intel.com>
In-Reply-To: <20200304174045.GC3315@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
        <20200228172537.377327-2-jean-philippe@linaro.org>
        <20200302161611.GD7829@8bytes.org>
        <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
        <20200303130155.GA13185@8bytes.org>
        <20200303084753-mutt-send-email-mst@kernel.org>
        <20200303155318.GA3954@8bytes.org>
        <20200303105523-mutt-send-email-mst@kernel.org>
        <20200304133707.GB4177@8bytes.org>
        <20200304153821.GE646000@myrica>
        <20200304174045.GC3315@8bytes.org>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 4 Mar 2020 18:40:46 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Mar 04, 2020 at 04:38:21PM +0100, Jean-Philippe Brucker wrote:
> > I agree with this. The problem is I don't know how to get a new
> > ACPI table or change an existing one. It needs to go through the
> > UEFI forum in order to be accepted, and I don't have any weight
> > there. I've been trying to get the tiny change into IORT for ages.
> > I haven't been given any convincing reason against it or offered
> > any alternative, it's just stalled. The topology description
> > introduced here wasn't my first choice either but unless someone
> > can help finding another way into ACPI, I don't have a better
> > idea.  
> 
> A quote from the ACPI Specification (Version 6.3, Section 5.2.6,
> Page 119):
> 
> 	Table signatures will be reserved by the ACPI promoters and
> 	posted independently of this specification in ACPI errata and
> 	clarification documents on the ACPI web site. Requests to
> 	reserve a 4-byte alphanumeric table signature should be sent
> to the email address info@acpi.info and should include the purpose
> 	of the table and reference URL to a document that describes
> the table format. Tables defined outside of the ACPI specification
> 	may define data value encodings in either little endian or big
> 	endian format. For the purpose of clarity, external table
> 	definition documents should include the endian-ness of their
> 	data value encodings.
> 
> So it sounds like you need to specifiy the table format and send a
> request to info@acpi.info to get a table signature for it.
> 
+ Mike and Erik who work closely on UEFI and ACPICA.

Copy paste Erik's initial response below on how to get a new table,
seems to confirm with the process you stated above.

"Fairly easy. You reserve a 4-letter symbol by sending a message
requesting to reserve the signature to Mike or the ASWG mailing list or
info@acpi.info

There is also another option. You can have ASWG own this new table so
that not one entity or company owns the new table."

> Regards,
> 
> 	Joerg

