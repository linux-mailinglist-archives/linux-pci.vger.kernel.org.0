Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4437838F4D0
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhEXVVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 17:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhEXVVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 17:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A23610CB;
        Mon, 24 May 2021 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621891176;
        bh=45mseiMLX+VRg8k4HxJvbUqvmcHdSxTUTYZE9HjSlXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=STIbd1XwViOD7aqzN/CLoroflcIe0OFOVv+i3/IgoUpyPkbIY3zaNJSVuNaa+oipl
         vIP5eAd5oAK49V5t8ZPxRj+hcraFcdtOfi87HRcvh652+CUMFDjzYaga7nfkqXVTvG
         hjzXyscUapBsZBz4Nl967qFPVZAZax29+EVjetxW7ZUUhHmih+ZjjbB7IqhksDQ+lC
         RiJ5CTagQBbWTwVtcRzEunCbCEZrH0zs+hqXJNUXLErrMtBWvQ1YCI5zmFFbR9coiL
         F26KuP3UCcnvjR4Xbn1dldKxx76IQoSE2zD81ezTtR8m4SuzEVmt9PMt+GdVvnE2WO
         3ekMElWocp1Wg==
Date:   Mon, 24 May 2021 16:19:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 03/14] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210524211934.GA1124194@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524211430.GA1123248@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 04:14:32PM -0500, Bjorn Helgaas wrote:
> On Tue, May 18, 2021 at 03:40:58AM +0000, Krzysztof Wilczyński wrote:
> > The sysfs_emit() and sysfs_emit_at() functions were introduced to make
> > it less ambiguous which function is preferred when writing to the output
> > buffer in a device attribute's "show" callback [1].
> > 
> > Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
> > and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
> > latter is aware of the PAGE_SIZE buffer and correctly returns the number
> > of bytes written into the buffer.
> > 
> > Modify the function dsm_label_utf16s_to_utf8s() to directly return the
> > number of bytes written into the buffer so that the strlen() used later
> > to calculate the length of the buffer can be removed as it would no
> > longer be needed.
> > 
> > No functional change intended.
> > 
> > [1] Documentation/filesystems/sysfs.rst
> > 
> > Related to:
> >   commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")
> > 
> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> > Changes in v2:
> >   None.
> > Changes in v3:
> >   Added Logan Gunthorpe's "Reviewed-by".
> >   Change style to the preferred one in the drivers/pci/slot.c file.
> > 
> >  drivers/pci/pci-label.c | 18 ++++++++++--------
> >  drivers/pci/slot.c      | 18 +++++++++---------
> >  2 files changed, 19 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> > index c32f3b7540e8..000e169c7197 100644
> > --- a/drivers/pci/pci-label.c
> > +++ b/drivers/pci/pci-label.c
> > @@ -139,14 +139,17 @@ enum acpi_attr_enum {
> >  	ACPI_ATTR_INDEX_SHOW,
> >  };
> >  
> > -static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
> > +static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
> >  {
> >  	int len;
> > +
> >  	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
> >  			      obj->buffer.length,
> >  			      UTF16_LITTLE_ENDIAN,
> >  			      buf, PAGE_SIZE);
> >  	buf[len] = '\n';
> > +
> > +	return len;
> >  }
> >  
> >  static int dsm_get_label(struct device *dev, char *buf,
> > @@ -154,7 +157,7 @@ static int dsm_get_label(struct device *dev, char *buf,
> >  {
> >  	acpi_handle handle = ACPI_HANDLE(dev);
> >  	union acpi_object *obj, *tmp;
> > -	int len = -1;
> > +	int len = 0;
> >  
> >  	if (!handle)
> >  		return -1;
> > @@ -175,20 +178,19 @@ static int dsm_get_label(struct device *dev, char *buf,
> >  		 * this entry must return a null string.
> >  		 */
> >  		if (attr == ACPI_ATTR_INDEX_SHOW) {
> > -			scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
> > +			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
> >  		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
> >  			if (tmp[1].type == ACPI_TYPE_STRING)
> > -				scnprintf(buf, PAGE_SIZE, "%s\n",
> > -					  tmp[1].string.pointer);
> > +				len = sysfs_emit(buf, "%s\n",
> > +						 tmp[1].string.pointer);
> >  			else if (tmp[1].type == ACPI_TYPE_BUFFER)
> > -				dsm_label_utf16s_to_utf8s(tmp + 1, buf);
> > +				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
> >  		}
> > -		len = strlen(buf) > 0 ? strlen(buf) : -1;
> >  	}
> >  
> >  	ACPI_FREE(obj);
> >  
> > -	return len;
> > +	return len > 0 ? len : -1;
> 
> I really like this, but I would like it even better if the
> sysfs_emit() change were easier to review.
> 
> It seems pointless that the current code uses strlen() when
> scnprintf() and dsm_label_utf16s_to_utf8s() both have that
> information and we just throw it away.
> 
> I think it should be possible to split the len and
> dsm_label_utf16s_to_utf8s() changes to a separate patch, which would
> remove the need for the strlen, and then the conversion to
> sysfs_emit() would be completely trivial like all the rest of them.
> 
> My goal is to make all the sysfs_emit() changes look almost
> mechanical, with the non-trivial parts separated out.

And BTW, when all the sysfs_emit() changes are trivial like that, I
would probably squash them all into one patch that converts all of
drivers/pci/ at once.

That would still leave a few separate patches:

  - This dsm_label_utf16s_to_utf8s() change
  - The resource_alignment newline change
  - The devspec_show newline change
  - The driver_override change
