Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE8174753
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 15:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgB2OYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 09:24:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:20293 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgB2OYN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Feb 2020 09:24:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 06:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,500,1574150400"; 
   d="scan'208";a="232825654"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Feb 2020 06:24:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j832H-0003a4-Nc; Sat, 29 Feb 2020 22:24:09 +0800
Date:   Sat, 29 Feb 2020 22:23:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iommu/virtio: Enable x86 support
Message-ID: <202002292217.iPza6SpM%lkp@intel.com>
References: <20200228172537.377327-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[cannot apply to pci/next linus/master v5.6-rc3 next-20200228]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jean-Philippe-Brucker/virtio-iommu-on-x86-and-non-devicetree-platforms/20200229-085019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/virtio-iommu.c:1024:9: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/iommu/virtio-iommu.c:1024:9: sparse:    restricted __le64 *
>> drivers/iommu/virtio-iommu.c:1024:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1036:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1036:9: sparse:    restricted __le64 *
   drivers/iommu/virtio-iommu.c:1036:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1040:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1040:9: sparse:    restricted __le64 *
   drivers/iommu/virtio-iommu.c:1040:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1044:9: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/iommu/virtio-iommu.c:1044:9: sparse:    restricted __le32 *
>> drivers/iommu/virtio-iommu.c:1044:9: sparse:    unsigned int *
   drivers/iommu/virtio-iommu.c:1048:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1048:9: sparse:    restricted __le32 *
   drivers/iommu/virtio-iommu.c:1048:9: sparse:    unsigned int *
   drivers/iommu/virtio-iommu.c:1052:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1052:9: sparse:    restricted __le32 *
   drivers/iommu/virtio-iommu.c:1052:9: sparse:    unsigned int *

vim +1024 drivers/iommu/virtio-iommu.c

edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   996  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   997  static int viommu_probe(struct virtio_device *vdev)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   998  {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   999  	struct device *parent_dev = vdev->dev.parent;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1000  	struct viommu_dev *viommu = NULL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1001  	struct device *dev = &vdev->dev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1002  	u64 input_start = 0;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1003  	u64 input_end = -1UL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1004  	int ret;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1005  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1006  	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1007  	    !virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP))
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1008  		return -ENODEV;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1009  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1010  	viommu = devm_kzalloc(dev, sizeof(*viommu), GFP_KERNEL);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1011  	if (!viommu)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1012  		return -ENOMEM;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1013  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1014  	spin_lock_init(&viommu->request_lock);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1015  	ida_init(&viommu->domain_ids);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1016  	viommu->dev = dev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1017  	viommu->vdev = vdev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1018  	INIT_LIST_HEAD(&viommu->requests);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1019  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1020  	ret = viommu_init_vqs(viommu);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1021  	if (ret)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1022  		return ret;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1023  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15 @1024  	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1025  		     &viommu->pgsize_bitmap);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1026  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1027  	if (!viommu->pgsize_bitmap) {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1028  		ret = -EINVAL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1029  		goto err_free_vqs;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1030  	}
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1031  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1032  	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1033  	viommu->last_domain = ~0U;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1034  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1035  	/* Optional features */
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1036  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1037  			     struct virtio_iommu_config, input_range.start,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1038  			     &input_start);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1039  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1040  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1041  			     struct virtio_iommu_config, input_range.end,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1042  			     &input_end);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1043  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22 @1044  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1045  			     struct virtio_iommu_config, domain_range.start,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1046  			     &viommu->first_domain);
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1047  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1048  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1049  			     struct virtio_iommu_config, domain_range.end,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1050  			     &viommu->last_domain);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1051  
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1052  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1053  			     struct virtio_iommu_config, probe_size,
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1054  			     &viommu->probe_size);
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1055  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1056  	viommu->geometry = (struct iommu_domain_geometry) {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1057  		.aperture_start	= input_start,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1058  		.aperture_end	= input_end,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1059  		.force_aperture	= true,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1060  	};
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1061  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1062  	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1063  		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1064  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1065  	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1066  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1067  	virtio_device_ready(vdev);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1068  
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1069  	/* Populate the event queue with buffers */
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1070  	ret = viommu_fill_evtq(viommu);
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1071  	if (ret)
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1072  		goto err_free_vqs;
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1073  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1074  	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1075  				     virtio_bus_name(vdev));
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1076  	if (ret)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1077  		goto err_free_vqs;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1078  
136495ceb43b56 Jean-Philippe Brucker 2020-02-28  1079  	virt_set_iommu_ops(dev->parent, &viommu_ops);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1080  	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1081  	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1082  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1083  	iommu_device_register(&viommu->iommu);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1084  

:::::: The code at line 1024 was first introduced by commit
:::::: edcd69ab9a323b7ac7a86e1c44b6c9c46598391f iommu: Add virtio-iommu driver

:::::: TO: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
